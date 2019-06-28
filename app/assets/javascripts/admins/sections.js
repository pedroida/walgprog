$(document).on('turbolinks:load', () => {
  const statusInput = $('#section_status');
  const alternativeInput = $('.section_alternative_text');
  WAlgProg.sectionsSortable();
  WAlgProg.saveSectionsOrder();
  WAlgProg.loadFontAwesomeIcons();
  WAlgProg.sectionStatusListener(statusInput, alternativeInput);
  statusInput.trigger('change');
});

WAlgProg.loadFontAwesomeIcons = () => {
  const sectionIcon = $('#section-icon').val();
  const iconSelect = $('.icon-select');
  const url = 'https://gist.githubusercontent.com/RobinMalfait/b2632576462910a4cd67/raw/'
    + '799d7d22dd418402e40f06c56cde7bdbd446927d/FontAwesome.json';
  $.get(url, (data) => {
    const parsed = JSON.parse(data).icons;
    $.each(parsed, (index, icon) => {
      const option = document.createElement('option');
      option.className = 'fa';
      option.value = icon.id;
      option.selected = sectionIcon === icon.id;
      option.innerHTML = `&#x${icon.unicode};  ${icon.id}`;
      iconSelect.append(option);
    });
  });
};

WAlgProg.sectionStatusListener = (input, inputToToggle) => {
  $(input).on('change', (event) => {
    const status = event.target.value;
    (status === 'other') ? inputToToggle.removeClass('hidden') : inputToToggle.addClass('hidden');
  });
};

WAlgProg.sectionsSortable = () => {
  $('tbody').sortable({
    group: 'no-drop',
    handle: '.section-to-order',
    onDragStart($item, container, _super) {
      if (!container.options.drop) $item.clone().insertAfter($item);
      _super($item, container);
    },
    update() {
      const sections = $('tbody .index-td');
      const maxSectionIndex = sections.length;
      $.each(sections, (index, section) => {
        $(section).html(maxSectionIndex - (index));
      });
    },
  });
};

WAlgProg.renderFlashMessage = (status, message) => {
  $('.alert').remove('.alert');
  $('.card-body').prepend(`<div class="alert alert-${status} alert-dismissible fade show" role="alert">
    <button class="close" data-dismiss="alert" aria-label="Close"></button>
        ${message}
    </div>`);
};

WAlgProg.saveSectionsOrder = () => {
  const sections = [];
  $('#save-sections-order').click(() => {
    const sectionsTr = $('tbody tr');
    $.each(sectionsTr, (index, section) => {
      sections.push({
        id: +$(section).find('.id-td').html(),
        index: +$(section).find('.index-td').html(),
      });
    });

    const eventId = $('#event_id').val();

    fetch(`/admins/events/${eventId}/sections/index`, {
      method: 'post',
      body: JSON.stringify({ list: sections }),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
      },
      credentials: 'same-origin',
    }).then(response => response.json())
      .then(success => WAlgProg.renderFlashMessage('success', success.message))
      .catch(error => WAlgProg.renderFlashMessage('error', error.message));
  });
};

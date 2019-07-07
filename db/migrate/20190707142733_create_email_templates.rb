class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string 'name', null: false
      t.string 'content_markdown', null: false
      t.string 'content', null: true
      t.timestamps
    end
  end
end

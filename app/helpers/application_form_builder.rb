# frozen_string_literal: true

class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  delegate :tag, to: :@template
  delegate :pluralize, to: :@template
  delegate :safe_join, to: :@template

  def error_explanation
    return if object.errors.blank?

    tag.div(id: 'error_explanation') do
      tag.h2(pluralize(object.errors.count,
                       'error') + " prohibited this #{object.model_name.human.downcase} from being saved:",
             class: 'dark:text-white') +
        tag.ul(class: 'dark:text-white') do
          safe_join(object.errors.full_messages.map { |msg| tag.li(msg) })
        end
    end
  end

  def labelled_check_box(method, label_options: {}, input_options: {})
    tag.div(class: 'field flex items-center') do
      check_box(method, merge_options(input_options, class: 'form-checkbox')) +
        label(method, merge_options(label_options, class: 'mt-1'))
    end
  end

  def labelled_collection_select(method, options, value, label, label_options: {}, select_options: {}, html_options: {})
    labelled_field(method, label_options) do
      tw_collection_select(method, options, value, label, select_options, html_options)
    end
  end

  # rubocop:disable Layout/LineLength
  def labelled_rich_collection_select(method, options, value, label, label_options: {}, select_options: {}, html_options: {})
    labelled_field(method, label_options) do
      rich_collection_select(method, options, value, label, select_options, html_options)
    end
  end
  # rubocop:enable Layout/LineLength

  def labelled_color_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_color_field(method, input_options) }
  end

  def labelled_date_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_date_field(method, input_options) }
  end

  def labelled_email_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_email_field(method, input_options) }
  end

  def labelled_number_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_number_field(method, input_options) }
  end

  def labelled_select(method, options, label_options: {}, select_options: {}, html_options: {})
    labelled_field(method, label_options) do
      tw_select(method, options, select_options, html_options)
    end
  end

  def labelled_rich_select(method, options, label_options: {}, select_options: {}, html_options: {})
    labelled_field(method, label_options) do
      rich_select(method, options, select_options, html_options)
    end
  end

  def labelled_telephone_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_telephone_field(method, input_options) }
  end

  def labelled_text_area(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_text_area(method, input_options) }
  end

  def labelled_text_field(method, label_options: {}, input_options: {})
    labelled_field(method, label_options) { tw_text_field(method, input_options) }
  end

  def labelled_file_field(method, label_options: {}, input_options: {})
    tag.div(class: 'field') do
      label(method, label_options) + tw_file_field(method, input_options)
    end
  end

  def labelled_trix_field(method, label_options: {}, input_options: {})
    tag.div(class: 'field') do
      label(method, label_options) + tw_trix(method, input_options)
    end
  end

  def labelled_field(method, label_options = {}, &block)
    tag.div(class: 'field') do
      label(method, label_options) + tag.div(class: 'input-container') { yield block }
    end
  end

  def rich_submit(value = nil, options = {})
    tag.span(class: 'w-full text-center py-3 rounded bg-indigo-600 text-white hover:bg-green-dark focus:outline-none my-1') do
      submit(value, options)
    end
  end

  def tw_collection_select(method, options, value, label, select_options = {}, html_options = {})
    collection_select(method, options, value, label, select_options, merge_options(html_options, class: 'form-select'))
  end

  def tw_select(method, options, select_options = {}, html_options = {})
    select(method, options, select_options, merge_options(html_options, class: 'form-select'))
  end

  def rich_collection_select(method, options, value, label, select_options = {}, html_options = {})
    collection_select(
      method,
      options,
      value,
      label,
      select_options,
      merge_options(html_options.deep_merge(data: { controller: 'rich-select' }), class: 'form-select')
    )
  end

  def rich_select(method, options, select_options = {}, html_options = {})
    select(
      method,
      options,
      select_options,
      merge_options(html_options.deep_merge(data: { controller: 'rich-select' }), class: 'form-select')
    )
  end

  def tw_color_field(method, input_options = {})
    color_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_date_field(method, input_options = {})
    date_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_email_field(method, input_options = {})
    email_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_number_field(method, input_options = {})
    number_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_telephone_field(method, input_options = {})
    telephone_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_text_area(method, input_options = {})
    text_area(method, merge_options(input_options, class: 'form-textarea'))
  end

  def tw_text_field(method, input_options = {})
    text_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_password_field(method, input_options = {})
    password_field(method, merge_options(input_options, class: 'form-input'))
  end

  def tw_file_field(method, input_options = {})
    file_field(method, input_options)
  end

  def tw_trix(method, input_options = {})
    rich_text_area(method, merge_options(input_options, class: 'prose prose-sm max-w-none'))
  end

  private

  def merge_options(input_options, defaults)
    defaults[:class] += ' block border border-grey-light w-full p-3 rounded mb-4 focus:outline-none focus:ring focus:border-blue-300'
    input_options.merge(defaults.merge(class: merge_classes(input_options, defaults[:class])))
  end

  def merge_classes(input_options, classes)
    found = input_options[:class]
    return found if classes.blank?

    return classes if found.blank?

    "#{found} #{classes}"
  end
end

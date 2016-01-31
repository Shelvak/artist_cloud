require 'test_helper'

<% module_namespacing do -%>
class <%= class_name %>Test < ActiveSupport::TestCase
  def setup
    @<%= singular_table_name %> = Fabricate(:<%= singular_table_name %>)
  end

  test 'create' do
    assert_difference ['<%= class_name %>.count', 'PaperTrail::Version.count'] do
      <%= class_name %>.create! Fabricate.attributes_for(:<%= singular_table_name %>)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference '<%= class_name %>.count' do
        @<%= singular_table_name %>.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @<%= singular_table_name %>.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('<%= class_name %>.count', -1) { @<%= singular_table_name %>.destroy }
    end
  end

  test 'validates blank attributes' do
    @<%= singular_table_name %>.attr = ''

    assert @<%= singular_table_name %>.invalid?
    assert_equal 1, @<%= singular_table_name %>.errors.size
    assert_equal_messages @<%= singular_table_name %>, :attr, :blank
  end

  test 'validates unique attributes' do
    new_<%= singular_table_name %> = Fabricate(:<%= singular_table_name %>)
    @<%= singular_table_name %>.attr = new_<%= singular_table_name %>.attr

    assert @<%= singular_table_name %>.invalid?
    assert_equal 1, @<%= singular_table_name %>.errors.size
    assert_equal_messages @<%= singular_table_name %>, :attr, :taken
  end
end
<% end -%>
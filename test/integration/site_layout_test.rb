require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    # ルートURL (Homeページ) にGETリクエストを送る.
    get root_path
    # 正しいページテンプレートが描画されているかどうか確かめる.
    assert_template 'static_pages/home'
    # 各ページへのリンクが正しく動くか確かめる.
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", contact_path
  end
  
end

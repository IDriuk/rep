defmodule RepWeb.CMS.PageView do
  use RepWeb, :view
  alias Rep.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end

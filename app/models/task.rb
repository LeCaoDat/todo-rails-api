class Task < ApplicationRecord
  def json_data
    {id: id, content: content, is_done: is_done, created_at: created_at, updated_at: updated_at}
  end
end

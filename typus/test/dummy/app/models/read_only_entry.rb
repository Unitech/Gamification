class ReadOnlyEntry < Entry

  attr_protected :title, :content, :published, :deleted_at, :as => :admin

end

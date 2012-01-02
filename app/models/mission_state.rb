class MissionState
  include StaticList::Model
  static_list [['New', 0], ['Taken', 1], ['Confirmed', 2], ['Finished', 3]]
end

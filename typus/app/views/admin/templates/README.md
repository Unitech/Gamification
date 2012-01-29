Some snippets to use in the future:

    <input type="hidden"
           id="pageListJSON"
           value="[<%= Page.all.map { |p| "['#{p.to_label}', '/pages/#{p.respond?(:permalink) p.permalink : p.id}']" }.join(", ") %>]">

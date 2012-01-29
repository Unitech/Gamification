CHANGELOG
=========

3.1.6 (unreleased)
------------------

 * [FIXED] "Save and continue editing" button was shown even when the
   user didn't have acess to it.

 * [CHANGED] Improved MongoDB support.

 * [NEW] We can now filter by integer.

 * [FIXED] Independent paginators when showing associations.

Changes: <https://github.com/fesplugas/typus/compare/v3.1.5...master>


3.1.5 (2011-12-10)
------------------

 * [CHANGED] Association tables now contain a "show" link.

 * [FIXED] Generators check if there's a database connection.

 * [CHANGED] ActsAsList module now can only perform whitelisted actions.

 * [CHANGED] ActsAsList hooks moved completely to it's module.

 * [CHANGED] Repository moved again to http://github.com/fesplugas/typus

Changes: <https://github.com/fesplugas/typus/compare/v3.1.4...v3.1.5>


3.1.4
-----

 * [FIXED] Belongs to helper was not creating properly class ids.

Changes: <https://github.com/fesplugas/typus/compare/v3.1.3...v3.1.4>


3.1.3
-----

 * [CHANGED] Added `Typus.chosen` so we can disable "Chosen". This will
   be in Typus until "Chosen" supports remote data calls.

 * [NEW] This is not really new ... I've taken back the autocomplete
   feature which will be used eventually by "Chosen" once they support
   remote calls.

 * [CHANGED] Typus::Resources.minute_step is now nil by default.

 * [CHANGED] Date and DateTime selectors should not set current date by default.

 * [CHANGED] Generator now stores model configuration in a file with the
   name of the model, not the plural.

 * [CHANGED] Generators can be run without setting up a database.

 * [CHANGED] We do not longer hide search boxes on Chosen. Apparently
   it has been fixed: https://github.com/harvesthq/chosen/commit/d4c7005b5c

 * [FIXED] Detaching a Paperclip was not working.

Changes: <https://github.com/fesplugas/typus/compare/v3.1.2...v3.1.3>


3.1.2
-----

 * [CHANGED] Images, links and belongs_to associations do not have links
   when popup mode. This will avoid an "Inception" problem.

 * [FIXED] Problems on HABTM associations when generating association names.


3.1.1
-----

 * [CHANGED] Removed user guide. Docs can now be found at http://docs.typuscmf.com/

 * [NEW] New configuration setting which allows serving Typus from a subdomain. (42b5d8ae)

 * [FIXED] HABTM associations were not working as expected when using namespaced
   models.

 * [CHANGED] Configuration can be read from subfolders so you can organize better
   your models. I'm starting to use a file per model and I'd recommend you start
   using it ... (8a3fc09f)

 * [FIXED] Helper Method `display_virtual` was not defined. (2b7e1948)

 * [FIXED] Do not show Trash link when user can't edit items.

 * [CHANGED] Updated Rubies list for Travis-CI.

 * [CHANGED] Default development/test database is now **Postgresql**.


3.1.0
-----

 * [NEW] Filter with scopes.

 * [NEW] Three different actions to save a record.

 * [CHANGED] Now we have a dashboard for every installed application.

 * [CHANGED] Associations are now cleaner. No more "relate" and "unrelate".

 * [NEW] 960.gs (http://960.gs/)

 * [NEW] Formalize (http://formalize.me/)

 * [NEW] Chosen (http://harvesthq.github.com/chosen/)

 * [CHANGED] We now support data types, which is basically a cleaner way to
   add support to future data models. (Eg. CarrierWave)

 * [CHANGED] Dragonfly attachments now also show details. (Size, date ...)

 * [CHANGED] Improved usability by using Fancybox to add new related records.

 * [NEW] Bulk actions.

 * [CHANGED] Controllers are now splitted into modules so we can have a library
   of common use cases.

 * [CHANGED] WillPaginate has been replaced by Kaminari.

 * [CHANGED] TypusCMS becomes TypusCMF.

 * [NEW] Applications tabs can be sorted!

 * [NEW] Models can be hidden from sidebars and dashboard.

 * [NEW] Module to enable Trash functionality. Need the rails-trash plugin.

 * [FIXED] We should be able to use namespaced models with more than 2 levels
   of namespace.

 * [CHANGED] We can't longer set models as "Read Only" from the configuration
   files, this was interesting but not really usefull as anyone could mass-assign
   attributes. Now to set an attribute as "Read Only" you only need to protect
   it using "attr_protected".

 * [NEW] Detect "attr_protected" roles.

 * [NEW] Asset pipeline usage. (Yes, we are in Rails 3.1)

 * [CHANGED] Removed "Autocomplete" module.

 * [NEW] Typus is now tested with Travis-CI.

 * [NEW] Improved MongoDB support.

 * [NEW] Improved Devise support out of the box.

 * [CHANGED] Improved how exporters work. Exporting only works if we define it
   on the model, otherwise will raise a 422 error.

 * [CHANGED] Updated mailer templates and renamed them. We are using the
   templates provided by Devise.

 * [CHANGED] We can set image sizes.

 * [CHANGED] Moved demo application to "test/dummy" following "enginex"
   conventions.

 * [CHANGED] We are not longer using FasterCSV on Ruby 1.8.7.

 * [NEW] Introduced the concept of "Widgets". Dashboard is now a "Widget".
 
 * [CHANGED] Custom actions are back!

 * [REMOVED] Read Only option has been removed from configuration files. This
   wasn't really protecting the forms. We are now using `attr_protected` with
   roles: `attr_protected :title, :as => :admin`.

 * [CHANGED] Configuration files are now generated by model not by groups.


3.0.12
------

 * [FIXED] Use will_paginate 3.0.0.


3.0.9
-----

 * [NEW] Refactored and renamed `User` extensions to `AdminUserV1`.

 * [NEW] `AdminUserV2` which uses `bcrypt` and it's simpler. This will be the
   default authentication mechanism for my new apps.


3.0.8
-----

 * [FIXED] Missing alias. (Commit 2af7d4cfd98bb0)


3.0.7
-----

 * [CHANGED] Updated assets. Please run the `typus:assets` generator in order
   to create the new files on the new location.


3.0.3
-----

 * [NEW] Support for has many through relationships. [jmeiss]

 * [CHANGED] Removed typus pagination module and use `will_paginate` one.
   Pagination options can be configure overriding `Typus.pagination` variable.

 * [FIXED] Queries are now using the table name. [tyx]

 * [NEW] All queries are `unscoped` so we can separate completely the frontend
   from the backend.

 * [NEW] We can disable sortable tables.

 * [FIXED] Url generation bug when using namespaced STI models. [masone]

 * [NEW] Raise an exception if config for model cannot be found. [masone]

 * [FIXED] Minor bug fixes and re-styling ...

 * [NEW] Layouts contain metatag with generator information.

 * [NEW] Added missing csrf_meta_tag in `session.html.erb` layout.

 * [NEW] Added constrain to database to avoid duplicated emails.

 * [FIXED] Dates on tables are localized.

 * [FIXED] `@resource.classify.constantize` becomes `@resource.constantize`.

 * [CHANGED] Updated `typus_preview` to display original filaname when file is
   not an image.

 * [NEW] Support for Dragonfly attachments. Template for this kind of attribute
   is `_dragonfly.html.erb`.

 * [CHANGED] Paperclip attachments are detected as `:paperclip` thus the form
   template is not `_paperclip.html.erb`.

 * [NEW] 中文 (zh-CN) translation. [ZoOL]

 * [CHANGED] `action_after_save` by default is `index`. This has been changed
   after a usability test with a client.

 * [NEW] Greek (el) translation. [Spyros Livathinos]

 * [CHANGED] Updated jQuery to v1.4.4

 * [CHANGED] Updated fancybox to v1.3.4

 * [NEW] New generator: `rails generate typus:assets`.

 * [NEW] Created UserVoice (http://typuscms.uservoice.com/)

 * [CHANGED] Table of contents on documentation for easier access.

 * [CHANGED] Display `&mdash;` where no content is available.

 * [NEW] `Admin::ResourcesController` includes `Typus::Extensions` if available.

 * [CHANGED] Removed `remove_filter_link` helper in favour of predefined links
   to filters.

 * [NEW] Custom actions can be injected into table actions. This needs some
   refector to be more powerful (roles) but it works for now.

 * [CHANGED] `current_user` is now `admin_user`.

 * [CHANGED] All available locales are shown to the user.

 * [CHANGED] All the I18n stuff of `typus` is now under Typus::I18n namespace.

 * [CHANGED] `/admin/help` is now `/admin/user_guide`.

 * [NEW] Link to `/admin/user_guide` from the sidebar.

 * [CHANGED] AdminUser::LANGUAGES becomes AdminUser::LOCALE so you'll have to
   update your AdminUser.

 * [NEW] Better application templates.


3.0.2
-----

 * [FIXED] Use Arel to get the data on lists. After moving to will_paginate I
   broke the data method, on each list we where "selecting ALL on the table of
   the current model" (Really ugly bug) [Reported by NateW]

 * [FIXED]* If @current_user was being set many times on each request, thanks
   to Rails caching mechanism this was not affecting to the performance. Now we
   only see the @current_user once. (As it should be.)


3.0.1
-----

 * [FIXED] After moving from a vendored paginator to will_paginate I removed
   some stuff which shouldn't be removed, so the 3.0.0 gem is totally broken.

 * [FIXED] Force query with postgresql adapter to not be case sensitive [jmeiss]


3.0.0
-----

 * [NEW] New gem version compatible with Rails 3.


Previously
----------

Why a 3.0.0 version? After considering the work done for the Rails 3 transition
I though it would be a good idea to keep versions syncronized with Rails.

**Typus** will have the same version numbers as Rails as I considered it's
pretty tied to it. With each release of Rails, we will take the latest features
into **Typus**.

Pending stuff that someday will be done, donations and collaborations are
accepted.

* Add AJAX, specially when removing and adding new relationships.

* Transversal search and full models search.

* Test the helpers and add some functional testing.

* Nested models.

* Contextual content depending on the role logged.

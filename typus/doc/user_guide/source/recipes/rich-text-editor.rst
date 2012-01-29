Adding a Rich Text Editor
=========================

CKEditor on Rails 3.1
---------------------

Include the ``rails-ckeditor`` gem in your ``Gemfile``:

.. code-block:: ruby

  gem "rails-ckeditor"

Once added update your bundle:

.. code-block:: bash

  bundle install

On you application configuration files (`config/typus`) you can now enable this
new template where needed. Eg.

.. code-block:: yaml

  Post:
    fields:
      default: title
      form: title, content
      options:
        templates:
          content: text_with_ckeditor


CKEditor on Rails 3.0
---------------------

Download `CKEditor`_ and unpack it into ``public/vendor``.

.. code-block:: bash

  mkdir -p public/vendor
  cd public/vendor
  curl -O http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.1/ckeditor_3.6.1.tar.gz
  tar xvzf ckeditor_3.6.1.tar.gz
  rm ckeditor_3.6.1.tar.gz

On you application configuration files (``config/typus``) you can now enable
this new template where needed. Eg.

.. code-block:: yaml

  Post:
    fields:
      default: title
      form: title, content
      options:
        templates:
          content: text_with_ckeditor

.. _CKEditor: http://ckeditor.com/

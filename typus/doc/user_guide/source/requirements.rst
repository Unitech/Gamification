Requirements
============

Are you using Rails 3.0?
------------------------

A clean ``admin`` namespace, this means, your application should not have any
controllers under ``controllers/admin`` as **Typus** will be "mounted" there.

Are you using Rails 2.3?
------------------------

**Typus** is available for Rails **2.3** but only as a `plugin`. I don't have
plans to mantain this version anymore but is still available for download
at `GitHub`_.

.. code-block:: bash

    script/plugin install https://github.com/typus/typus.git -r 2-3-stable

.. note::

  Not all documentation of this site works on the **Rails 2.3** version of
  **Typus**. I recommend you upgrading to **Rails 3.0** in order to use the
  latest **Typus** features.

.. _GitHub: https://github.com/typus/typus/tree/2-3-stable

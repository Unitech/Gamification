Attribute Templates
===================

It is possible to change the presentation for an attribute within the form.
In the example below the ``published_at`` attribute is datetime attribute
and will use the ``_datetime.html.erb`` template located on the templates
folder ``app/views/admin/templates``. The resource and the attribute name
will be sent as local variables ``resource`` and ``attribute``.

.. code-block:: erb

  # app/views/admin/templates/_datetime.html.erb
  <li><label><%= t(attribute.humanize) %></label>
    <%= calendar_date_select :item, attribute %>
  </li>

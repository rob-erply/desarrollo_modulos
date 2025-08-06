odoo.define('prueba_manifest_profesional.widget', function (require) {
    "use strict";
    var Widget = require('web.Widget');
    var core = require('web.core');

    var MyWidget = Widget.extend({
        template: 'MyWidgetTemplate',
        start: function () {
            this.$el.text('¡Hola desde el widget JS profesional!');
            return this._super();
        }
    });

    core.action_registry.add('my_widget_action', MyWidget);
    return MyWidget;
});

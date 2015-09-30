var IDom = require('incremental-dom');

// module Incremental.DOM

function unfoldAttributes (attributes) {
    return attributes.reduce(function (attrs, v) {
        var a = v.value0;
        var val = a.value;
        var name = a.name;
        var isStatic = a.static;
        if (name === 'value') {
            val = new String(val);
        }

        if(val === '__UNSET__') {
            //ignore
        } else if (name === 'key') {
            attrs.key = val;
        } else if (isStatic) {
            attrs.statics.push(name);
            attrs.statics.push(val);
        } else {
            attrs.attributes.push(name);
            var valueToPush = val;
            if(typeof valueToPush === 'function') {
                valueToPush = function(event) {
                    var effect = val(event);
                    effect();
                };
            }
            attrs.attributes.push(valueToPush);
        }
        return attrs;
    }, {statics : [], key: null, attributes: []});
}

exports.element = function (tagName) {
        return function (attrs) {
            return function (children) {
                return function() {
                    var unfoldedAttrs = unfoldAttributes(attrs);
                    var args = [tagName, unfoldedAttrs.key, unfoldedAttrs.statics].concat(unfoldedAttrs.attributes);
                    IDom.elementOpen.apply(null, args);
                    children();
                    IDom.elementClose(tagName);
                };
            };
        };
};

exports.text = function(text) {
    return function() {
        IDom.text(text);
    };
};


exports.patch = function (iRootElement) {
    return function (domElement) {
        return function iDomEffect() {
            IDom.patch(domElement, iRootElement, {});
            return {};
        }
    };
};

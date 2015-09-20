//module Incremental.Attributes

exports.objPropAccessorImpl = function (just) {
    return function (nothing) {
        return function (prop) {
            return function (obj) {
                if (obj[prop] != null) {
                    return just(obj[prop]);
                } else {
                    return nothing;
                }
            };
        };
    };
};

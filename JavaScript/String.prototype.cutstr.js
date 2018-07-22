/**
 * 字符串裁剪扩展
 *
 * 这是一个支持中文的 JavaScript 字符串裁剪扩展方法，主要解决了 JavaScript 裁剪中文和英文的长度差距过大的问题。
 * 注意：本方法没有转换实体字符的功能。
 *
 * @copyright   ZhangTianJie All rights reserved.
 * @license     GNU General Public License version 2 or later.
 */

String.prototype.cutstr = function (len) {
    var str = this.replace(/\r\n/g, '')
        .replace(/\n/g, '')
        .replace(/<br>/g, '')
        .replace(/<br\/>/g, '')
        .replace(/<br \/>/g, '');
    var str_len = str.length;
    var str_cut = '';
    var str_char = '';
    var for_len = '';

    for (var i = 0; i < str_len; i++) {
        str_char = str.charAt(i);
        for_len++;
        if (encodeURI(str_char).length > 4) {
            for_len++;
        }
        str_cut = str_cut.concat(str_char);
        if (for_len >= len) {
            str_cut = str_cut.concat('...');
            return str_cut;
        }
    }

    return str;
};

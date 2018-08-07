/**
 * 字节高位转换
 *
 * @copyright   ZhangTianJie All rights reserved.
 * @license     GNU General Public License version 2 or later.
 */

String.prototype.bytes = function (size) {
    var format_text = ['B', 'KB', 'MB', 'GB', 'TB'];
    if (size === '') return '';
    size = parseInt(size);
    var i = 0;
    while (size >= 1024) {
        size /= 1024;
        i++;
    }
    if (size === 0) {
        return '0 KB';
    } else {
        return size.toFixed(0) + ' ' + format_text[i];
    }
};

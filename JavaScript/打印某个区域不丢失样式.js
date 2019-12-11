/**
 * 打印某个区域不丢失样式
 *
 * @copyright   ZhangTianJie All rights reserved.
 * @email       ztj1993@gmail.com
 * @license     GNU General Public License version 2 or later.
 */

node_name = '#content_left';
node_css = {
    'position': 'absolute',
};

script = document.createElement('script');
script.src = 'https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js';
document.head.appendChild(script);

node_ele = $(node_name);
node_parents = node_ele.parentsUntil('body');

node_html = node_ele.clone();
node_html.css(node_css);
node_parents.map(function () {
    tmp = $(this).clone().empty();
    node_html = tmp.append(node_html)
});

body = $('body');
body.children().hide();
body.append(node_html);
window.print();
node_html.remove();
body.children().show();

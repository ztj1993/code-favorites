class WebViewKernelAttrs {
    is_app: boolean = false;
    is_browser: boolean = false;
    is_mobile: boolean = false;
    is_android: boolean = false;
    is_iphone: boolean = false;
    is_ipad: boolean = false;
    is_safari: boolean = false;
    is_weibo: boolean = false;
    is_qq: boolean = false;
    is_web_kit: boolean = false;
}

class WebViewKernel {
    attrs = new WebViewKernelAttrs();
    user_agent: string = 'unknown';

    constructor() {
        try {
            this.user_agent = navigator.userAgent.toLowerCase();
            this.attrs.is_browser = true;
            this.attrs.is_web_kit = this.user_agent.indexOf('applewebkit') > -1;
            this.attrs.is_mobile = !!this.user_agent.match(/applewebkit.*mobile.*/);
            this.attrs.is_android = this.user_agent.indexOf('android') > -1;
            this.attrs.is_iphone = this.user_agent.indexOf('iphone') > -1;
            this.attrs.is_ipad = this.user_agent.indexOf('ipad') > -1;
            this.attrs.is_safari = this.user_agent.indexOf('safari') > -1;
            this.attrs.is_weibo = this.user_agent.indexOf('weibo') > -1;
            this.attrs.is_qq = this.user_agent.indexOf('qq') > -1;
        } catch (e) {
            //TODO: 这里的判断太武断
            this.attrs.is_app = true;
        }
    }

    get_user_agent() {
        return this.user_agent;
    }

    get_attrs(): object {
        return this.attrs;
    }

    is_app(): boolean {
        return this.attrs.is_app;
    }

    is_is_browser(): boolean {
        return this.attrs.is_browser;
    }

    is_web_kit(): boolean {
        return this.attrs.is_web_kit;
    }

    is_mobile(): boolean {
        return this.attrs.is_mobile;
    }

    is_android(): boolean {
        return this.attrs.is_android;
    }
}

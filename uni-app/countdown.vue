<template>
    <view class="uni-countdown">
        <text>{{ h }}</text>
        <text>:</text>
        <text>{{ i }}</text>
        <text>:</text>
        <text>{{ s }}</text>
    </view>
</template>
<script>
    export default {
        name: 'UniCountdown',
        props: {
            hour: {
                type: Number,
                default: 0,
            },
            minute: {
                type: Number,
                default: 0,
            },
            second: {
                type: Number,
                default: 0,
            }
        },
        data() {
            return {
                debug: false,
                timer: null,
                h: '00',
                i: '00',
                s: '00',
                seconds: 0,
            }
        },
        watch: {
            hour(val) {
				this.debug && console.log('CountDown - Watch - hour');
				this.debug && console.log('hour: ' + val);
                this.changeFlag()
            },
            minute(val) {
				this.debug && console.log('CountDown - Watch - minute');
				this.debug && console.log('minute: ' + val);
                this.changeFlag()
            },
            second(val) {
				this.debug && console.log('CountDown - Watch - minute');
				this.debug && console.log('second: ' + val);
                this.changeFlag()
            }
        },
        created: function (e) {
			this.debug && console.log('CountDown - Created');
            this.startData();
        },
        beforeDestroy() {
            clearInterval(this.timer)
        },
        methods: {
			startData() {
				this.seconds = this.toSeconds(this.hour, this.minute, this.second);
				if (this.seconds <= 0) {
					return
				}
				this.countDown();
				this.timer = setInterval(() => {
					this.seconds--;
					if (this.seconds < 0) {
						this.timeUp();
						return
					}
					this.countDown()
				}, 1000)
			},
            toSeconds(hours, minutes, seconds) {
                return hours * 60 * 60 + minutes * 60 + seconds
            },
            timeUp() {
                clearInterval(this.timer)
                this.$emit('timeup')
            },
            countDown() {
                let seconds = this.seconds;
                let [hour, minute, second] = [0, 0, 0];
                if (seconds > 0) {
                    hour = Math.floor(seconds / (60 * 60));
                    minute = Math.floor(seconds / 60) - (hour * 60);
                    second = Math.floor(seconds) - (hour * 60 * 60) - (minute * 60)
                } else {
                    this.timeUp()
                }
                if (hour < 10) {
                    hour = '0' + hour
                }
                if (minute < 10) {
                    minute = '0' + minute
                }
                if (second < 10) {
                    second = '0' + second
                }
                this.h = hour;
                this.i = minute;
                this.s = second;
            },
            changeFlag() {
                this.debug && console.log('CountDown - ChangeFlag');
				this.debug && console.log('hour: ' + this.hour);
				this.debug && console.log('minute: ' + this.minute);
				this.debug && console.log('second: ' + this.second);
				clearInterval(this.timer)
				this.seconds = this.toSeconds(this.hour, this.minute, this.second);
				this.startData();
            }
        }
    }
</script>
<style>
</style>

<template>
    <view>
        <image
                v-if="is_play"
                :src="play_icon"
                class="play_music"
                ref="play_music"
                @tap="trigger()">
        </image>
        <image
                v-else
                :src="stop_icon"
                ref="stop_music"
                class="stop_music"
                @tap="trigger()">
        </image>
    </view>
</template>
<script>
    export default {
        name: 'music',
        props: {
            play_state: {
                type: Boolean,
                default: false,
            },
            play_icon: {
                type: String,
                default: '/static/music/play.png',
            },
            stop_icon: {
                type: String,
                default: '/static/music/stop.png',
            },
            audio_src: {
                type: String,
                default: '/static/music/audio.aac',
            },
        },
        data() {
            return {
                is_play: null,
                is_support: true,
                audio: null,
                src: null,
            }
        },
        watch: {
            play_state(val) {
                this.is_play = this.play_state;
            },
            is_play(val) {
                if (val) {
                    this.play();
                } else {
                    this.stop();
                }
            }
        },
        created() {
            console.log('----------Created----------');
            try {
                this.audio = uni.getBackgroundAudioManager();
                this.audio.src = this.audio_src;
                this.audio.onEnded((res) => {
                    this.play();
                });
            } catch (e) {
                console.log('浏览器不支持此功能');
                this.is_support = false;
            }
            if (this.play_state) {
                this.is_play = true;
            }
        },
        mounted() {
            console.log('----------Mounted----------');
        },
        methods: {
            trigger() {
                console.log('----------Trigger----------');
                this.is_play = !this.is_play;
            },
            play() {
                console.log('----------Play----------');
                if (this.is_support) {
                    this.audio.play()
                }
            },
            stop() {
                console.log('----------Stop----------');
                if (this.is_support) {
                    this.audio.pause()
                }
            },
        }
    }
</script>
<style>

</style>

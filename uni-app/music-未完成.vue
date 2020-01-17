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
        },
        mounted() {
            console.log('----------Mounted----------');
            this.audio = uni.createInnerAudioContext();
            this.audio.src = this.audio_src;
            this.audio.loop = true;
            if (this.play_state) {
                this.audio.autoplay = true;
                this.is_play = true;
            }
        },
        methods: {
            trigger() {
                console.log('----------Trigger----------');
                this.is_play = !this.is_play;
            },
            play() {
                console.log('----------Play----------');
                if (this.audio.paused && !this.audio.autoplay) {
                    this.audio.play()
                }
            },
            stop() {
                console.log('----------Stop----------');
                this.audio.autoplay = false;
                this.audio.stop()
            },
        }
    }
</script>
<style>

</style>

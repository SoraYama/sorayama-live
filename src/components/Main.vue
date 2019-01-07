<template>
  <div id="wrapper" />
</template>

<style lang="less">
#wrapper {
  position: relative;
  display: block;
  margin: 0 auto;
  width: 80vw;
  height: 80vh;

  chimee-control-wrap {
    background: #eaeaea !important;
  }

  danmu {
    flex: 1;
    cursor: initial;

    #danmu-input {
      width: 80%;
    }
  }
}
video {
  width: 100%;
  height: 100%;
  display: block;
  background-color: #000;
}
video:focus,
video:active {
  outline: none;
}
</style>

<script>
import Chimee from 'chimee'
import flv from 'chimee-kernel-flv'
import chimeePluginDanmu from 'chimee-plugin-danmu'
import controlBar from 'chimee-plugin-controlbar'
import io from '../socket'

Chimee.install(chimeePluginDanmu)
Chimee.install(controlBar)

export default {
  data() {
    return {
      url: `http://play.sorayamah.org/live/sorayama.flv`,
    };
  },

  mounted() {
    const chimee = new Chimee({
      wrapper: '#wrapper',
      src: 'http://play.sorayamah.org/live/sorayama.flv',
      controls: true,
      autoplay: true,
      box: 'flv',
      kernels: {
        flv,
      },
      isLive: true,
      plugin: [{
        name: chimeePluginDanmu.name,
        mode: 'canvas'
      }, {
        name: controlBar.name,
        // barShowByMouse: '',
        majorColor: '#666',
        hoverColor: '#3b7ded',
        children: {
          play: {},
          danmu: {
            tag: 'danmu',
            html: `
              <div class="danmu-wrapper">
                <input onclick="document.querySelector('#danmu-input').focus()" id="danmu-input" placeholder="请输入弹幕" />
                <button id="danmu-send">发送</button>
              </div>
            `,
          },
          volume: {},
          screen: {},
        },
      }],
    })

    const sendDanmaku = text => chimee.__dispatcher.plugins.chimeeDanmu.sendMsg({text, speed: 2, fontSize: 30});

    document.querySelector('#danmu-send').addEventListener('click', () => {
      const text = document.querySelector('#danmu-input').value
      io.emit('danmaku', text)
      sendDanmaku(text)
    })

    io.on('danmaku', text => {
      // eslint-disable-next-line no-console
      console.log('Recieve danmaku: ', text)
      sendDanmaku(text)
    })
  },
};
</script>

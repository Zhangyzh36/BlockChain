<template>
    <el-container>
        <el-header></el-header>
        <el-main>
            <el-row>
                <div id="app">
                  <img src="./../assets/logo.jpg">
                </div>
            </el-row>
            <el-row>
                <el-col :span='8' align='center'>文</el-col>
                <el-col :span='8'>
                    <el-card>
                        <el-form :model='loginForm'>
                            <el-form-item><el-input placeholder='用户名' v-model='loginForm.username'></el-input></el-form-item>
                            <el-form-item><el-button type='primary' @click='login'>登录</el-button></el-form-item>
                            <el-form-item><el-button type='text' @click='switchToRegister'>没有账号？前往注册</el-button></el-form-item>
                        </el-form>
                    </el-card>
                </el-col>
                <el-col :span='8' align='center'>体</el-col>
            </el-row>
        </el-main>
        <el-footer></el-footer>
  </el-container>
</template>
<script>

import config from './../global/config.vue'

export default {
  name: 'login',
  data () {
    return {
      loginForm: {
        username: ''
      },

      accounts: [],
      teacher: config.TEACHER_ADDRESS,
      myManager: null,
      address: null
    }
  },

  created () {
    var abi = config.ABICODE_HOMEWORK_MANAGER
    var code = config.BYTECODE_HOMEWORK_MANAGER
    var contract = this.$web3.eth.contract(abi)
    this.$web3.db.getString('DB', 'address', function (err, data) {
      if (!err) {
        if (data !== '') {
          this.address = data
          this.myManager = contract.at(config.CONTRACT_ADDRESS)
        } else {
        }
      } else {
        console.log(err)
        var fromAddr = this.$web3.eth.accounts[0]
        var myHomeworkManager = contract.new({
          data: code,
          from: fromAddr
        }, function (err, myContract) {
          if (!err) {
            // 注意：这个回调会触发两次
            // 一次是合约的交易哈希属性完成
            // 另一次是在某个地址上完成部署
            // 通过判断是否有地址，来确认是第一次调用，还是第二次调用。
            if (!myContract.address) {
              console.log('contract deploy transaction hash: ' + myContract.transactionHash)
            } else {
              this.$web3.db.putString('DB', 'address', myContract.address)
              this.myManager = contract.at(config.CONTRACT_ADDRESS)
              console.log('hhh' + myHomeworkManager)
            }
          } else {
          }
        })
      }
    })
  },

  methods: {
    login () {
      if (!window.localStorage) {
        this.$message.error('浏览器不支持本地缓存，请升级！')
      } else if (this.checkLoginForm()) {
        this.postLoginForm()
      }
    },

    checkLoginForm () {
      if (this.loginForm.username === '') {
        this.$message.error('请输入用户名')
        return false
      }
      return true
    },

    postLoginForm () {
      this.$web3.db.getString('DB', 'address', function (err, data) {
        if (!err) {
          console.log(data)
        }
      })
      var account = this.$web3.eth.accounts[0]
      if (account === config.TEACHER_ADDRESS) {
        this.$router.push('tearcher')
      } else {
        console.log(this.myManager)
        console.log('after contract deploy, call:' + this.myManager.homeworkNum.call())
        this.$router.push('students')
      }
    },

    switchToRegister () {
      this.$router.push('register')
    }
  }
}
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
<style scoped>
.el-card {
    /* display: block; */
    width: 100%;
}

.el-button {
    width: 100%;
}

.padding {
    background: 0xffffff;
    border-radius: 4px;
}
</style>

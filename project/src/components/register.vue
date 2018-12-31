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
                <el-col :span="8" align='center'>文</el-col>
                <el-col :span="8">
                    <el-card>
                        <el-form :model="registerForm">
                            <el-form-item><el-input placeholder="用户名" v-model="registerForm.username"></el-input></el-form-item>
                            <el-form-item><el-button type="primary" @click="register">注册</el-button></el-form-item>
                            <el-form-item><el-button type="text" @click="switchToLogin">已有账号？返回登录</el-button></el-form-item>
                        </el-form>
                    </el-card>
                </el-col>
                <el-col :span="8" align='center'>体</el-col>
            </el-row>
        </el-main>
        <el-footer></el-footer>
  </el-container>
</template>

<script>

export default {
  name: 'register',
  data () {
    return {
      registerForm: {
        username: ''
      }
    }
  },
  methods: {
    register () {
      if (this.checkRegisterForm()) {
        return this.postRegisterForm()
      }
    },
    checkRegisterForm () {
      return true
    },
    postRegisterForm () {
    },
    switchToLogin () {
      this.$router.push('/')
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.el-button {
    /* display: block; */
    width: 100%;
}
</style>

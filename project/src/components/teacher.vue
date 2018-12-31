<template>
<el-container>
    <el-header></el-header>
    <el-main>
        <el-card>
            <el-row>
                <el-table :data="homeworks" stripe @row-click="clickAccountRow">
                    <el-table-column prop="1" label="已发布作业"></el-table-column>
                    <el-table-column prop="2" label="提交人数"></el-table-column>
                    <el-table-column prop="3" label="总人数"></el-table-column>
                    <el-table-column prop="4" label="已批改"></el-table-column>
                    <el-table-column prop="5" label="截至时间"></el-table-column>
                </el-table>
            </el-row>

            <el-row style="margin-top: 20px;">
                <el-pagination
                    @size-change="changeJobPageSize"
                    @current-change="changeJobPageCurrent"
                    :current-page="jobPageCurrent"
                    :page-sizes="jobPageSizes"
                    :page-size="jobPageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="total">
                </el-pagination>
            </el-row>
        </el-card>
    </el-main>
    <el-footer></el-footer>
</el-container>
</template>

<script>

export default {
  name: 'teacher',

  data () {
    return {
      homeworks: [
        {
          '1': 'Homework1',
          '2': '3',
          '3': '10',
          '4': '2',
          '5': '2018-01-01'
        },
        {
          '1': 'Homework2',
          '2': '10',
          '3': '15',
          '4': '6',
          '5': '2018-12-31'
        }
      ],
      total: 0,
      jobPageCurrent: 1,
      jobPageSizes: [5, 10, 30, 50, 1000, 2000, 5000],
      jobPageSize: 10
    }
  },
  created () {
    this.loadHomeworks()
    console.log(666)
  },
  methods: {
    loadHomeworks () {
      /*
      var offset = (this.jobPageCurrent - 1) * this.jobPageSize
      this.$http.get(config.apiUrl + '/jobs/' + '?offset=' + offset + '&limit=' + this.jobPageSize).then(res => {
        this.jobs = res.body.data
        this.total = res.body.total
        var jobStateCode = { '200': '未标注', '201': '标注中', '202': '已完成' }
        for (var i = 0; i < this.jobs.length; i++) {
          this.jobs[i].state = jobStateCode[this.jobs[i].job_state]
        }
      }, res => {
        this.$message.error('请求任务信息错误')
        // eslint-disable-next-line
        console.log(res)
      });
      */
    },
    changeJobPageSize (val) {
      this.jobPageSize = val
      if (this.total <= this.jobPageSize * (this.jobPageCurrent - 1)) {
        this.jobPageCurrent = Math.ceil(this.total / this.jobPageSize)
      }
      this.loadHomeworks()
    },
    changeJobPageCurrent (val) {
      this.jobPageCurrent = val
      this.loadHomeworks()
    },
    submit () {
    }
  }
}
</script>

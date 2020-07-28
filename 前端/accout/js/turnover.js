var httpUrl = 'http://106.14.125.136/acc';
//var httpUrl = 'http://106.14.125.136:6666';
//数据获取及绑定
var vueData = new Vue({
	el: '#trydiv',
	data: {
		today: {
			year: new Date().getFullYear(),
			month: new Date().getMonth() + 1,
			day: new Date().getDate()
		},
		weekday: {
			year: new Date(new Date().getTime() - 6 * 24 * 3600 * 1000).getFullYear(),
			month: new Date(new Date().getTime() - 6 * 24 * 3600 * 1000).getMonth() + 1,
			day: new Date(new Date().getTime() - 6 * 24 * 3600 * 1000).getDate()
		},
		year_sales: {
			income: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			outcome: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			sumcome: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		},
		type_sales: {
			type: [],
			income: [],
		},
		consum_sales: {
			type: [],
			income: []
		},
		detailData: {},
		time_sales: {
			showDate: null,
			time: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
			income: [], //[时间,次数,金额]
			maxTimes: 0
		},
		staff_sales: {
			type: [],
			income: [
				[], //服务次数
				[] //创造收益
			],
		},
		day_sales: {
			type: ['', '', '', '', '', '', ''],
			income: [0, 0, 0, 0, 0, 0, 0]
		},
		add_date: '',
	},
	mounted() {
		this.get_year_sales();
		this.get_type_sales();
		this.get_consum_sales();
		// this.get_time_sales();//此功能在this.get_consum_sales()中调用
		//this.get_staff_sales();//此功能在this.get_consum_sales()中调用
		// console.log(this.staff_sales);
		this.get_day_sales();
	},
	methods: {
		get_year_sales() {
			this.$http.get(httpUrl + '/turnover?size=366', {
				params: {
					"endTime": this.today.year + "-12-31 24:00:00",
					"startTime": this.today.year + "-01-01 00:00:00"
				}
			}).then(res => {
				// console.log(res);
				if (res.body.success) {
					var data = res.body.data.records;
					for (var i = 0; i < data.length; i++) {
						this.year_sales.income[data[i].date.substr(5, 2) - 1] += data[i].moneyIncome;
						this.year_sales.outcome[data[i].date.substr(5, 2) - 1] += data[i].moneyOutcome;
						this.year_sales.sumcome[data[i].date.substr(5, 2) - 1] += data[i].sumIncome;
					}
				}
				this.make_year_sales();
			}).catch(err => {
				console.log(err);
			})
		},
		make_year_sales() {
			//第一个图表
			var year_sales = echarts.init(document.getElementById('year_sales'));

			// 指定图表的配置项和数据
			var year_sales_option = {
				title: {
					text: this.today.year + "年销量"
				},
				tooltip: {
					trigger: 'axis',
				},
				legend: {
					data: ['入账', '出账', '合计']
				},
				xAxis: {
					type: 'category',
					boundaryGap: false,
					data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
				},
				yAxis: {
					type: 'value',
					min: 0,
					max: Math.ceil(Math.max.apply(null, this.year_sales.income) / 10) * 10,
				},
				series: [{
					name: '入账',
					type: 'line',
					smooth: true,
					data: this.year_sales.income,
					symbolSize: 10,
				}, {
					name: '出账',
					type: 'line',
					smooth: true,
					data: this.year_sales.outcome,
					symbolSize: 10,
				}, {
					name: '合计',
					type: 'line',
					smooth: true,
					data: this.year_sales.sumcome,
					symbolSize: 10,
				}],
				grid: {
					show: true,
				}
			};

			// 使用刚指定的配置项和数据显示图表。
			year_sales.setOption(year_sales_option);
			//    ------------------------------------------------------------------
		},
		get_type_sales() {
			this.$http.get(httpUrl + '/busness/group?type=1').then(res => {
				// console.log(res);
				if (res.body.success) {
					var data = res.body.data;
					// for (var i = 0; i < data.length; i++) {
					// 	this.type_sales.income.push(data[i])
					// }
					for (var key in data) {
						this.type_sales.income.push(data[key]);
						this.type_sales.type.push({
							'name': key,
							'max': 10
						});
					}
					for (var i = 0; i < this.type_sales.income.length; i++) {
						this.type_sales.type[i].max = Math.ceil(Math.max.apply(null, this.type_sales.income) / 10) * 10;
					}
				}
				this.make_type_sales();
			}).catch(err => {
				console.log(err);
			})
		},
		make_type_sales() {
			//    第二个图表
			var product_sales = echarts.init(document.getElementById('product_sales'));

			// 指定图表的配置项和数据
			var product_sales_option = {
				title: {
					text: '消费类型统计'
				},
				tooltip: {},
				legend: {
					data: '出售量'
				},
				radar: {
					name: {
						textStyle: {
							color: '#fff',
							backgroundColor: '#999',
							borderRadius: 3,
							padding: [3, 5]
						}
					},
					indicator: this.type_sales.type
				},
				series: [{
					name: '消费类型',
					type: 'radar',
					symbolSize: 10,
					// areaStyle: {normal: {}},
					data: [{
						value: this.type_sales.income,
						name: '销售量'
					}]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			product_sales.setOption(product_sales_option);
			//    ------------------------------------------------------------------
		},
		get_consum_sales() {
			this.$http.get(httpUrl + '/consum/list?size=45').then(res => {
				// console.log(res);
				if (res.body.success) {
					var data = res.body.data.records;
					this.detailData = data;
					// console.log(data);
					for (var i = 0; i < data.length; i++) {
						this.consum_sales.type.push({
							'customerId': data[i].customerId,
							'customerName': data[i].customerName
						})
					}
					for (var i = 0; i < this.consum_sales.type.length; i++) {
						for (var j = i + 1; j < this.consum_sales.type.length; j++) {
							if (this.consum_sales.type[i].customerId == this.consum_sales.type[j].customerId) { //第一个等同于第二个，splice方法删除第二个
								this.consum_sales.type.splice(j, 1);
								j--;
							}
						}
					}
					// console.log(this.consum_sales.type);
					for (var i = 0; i < this.consum_sales.type.length; i++) {
						if (this.consum_sales.type[i].customerId) {
							this.consum_sales.income.push({
								'value': 0,
								'name': this.consum_sales.type[i].customerName + "\n(ID:" + this.consum_sales.type[i].customerId + ")",
								'id': this.consum_sales.type[i].customerId
							});
						}
					}
					for (var i = 0; i < data.length; i++) {
						for (var j = 0; j < this.consum_sales.income.length; j++) {
							if (data[i].customerId == this.consum_sales.income[j].id) {
								this.consum_sales.income[j].value += data[i].price;
							}
						}
					}
				}
				this.make_consum_sales();
				this.get_time_sales();
				this.get_staff_sales();
			}).catch(err => {
				console.log(err);
			})
		},
		make_consum_sales() {
			//    第三个图表主要顾客的消费记录
			var consum_sales = echarts.init(document.getElementById('consum_sales'));

			// 指定图表的配置项和数据
			var consum_sales_option = {
				title: {
					text: '近期顾客消费记录',
					x: 'center'
				},
				tooltip: {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data: vueData.$data.consum_sales.income
				},
				series: [{
					name: '近期顾客',
					type: 'pie',
					radius: '55%',
					center: ['50%', '60%'],
					data: vueData.$data.consum_sales.income,
					itemStyle: {
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					}
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			consum_sales.setOption(consum_sales_option);
			//    ------------------------------------------------------------------
		},
		get_time_sales() {
			this.time_sales.showDate = parseInt(this.detailData[0].payTime.substr(5, 2)) * 100 + parseInt(this.detailData[0].payTime
				.substr(8, 2));
			for (var i = 0; i < this.detailData.length; i++) {
				if (this.time_sales.showDate < parseInt(this.detailData[i].payTime.substr(5, 2)) * 100 + parseInt(this.detailData[
						i].payTime.substr(8, 2))) {
					this.time_sales.showDate = parseInt(this.detailData[i].payTime.substr(5, 2)) * 100 + parseInt(this.detailData[i]
						.payTime.substr(8, 2))
				}
			}
			var time = [];
			// console.log(this.time_sales.showDate);
			for (var i = 0; i < this.detailData.length; i++) {
				if (this.time_sales.showDate == parseInt(this.detailData[i].payTime.substr(5, 2)) * 100 + parseInt(this.detailData[
						i].payTime.substr(8, 2))) {
					this.detailData[i].dealPayTime = parseInt(this.detailData[i].payTime.substr(11, 2)) + Math.round((Math.round(
						parseInt(this.detailData[i]
							.payTime.substr(14, 2)) / 10) / 6) * 10) / 10;
					time.push(this.detailData[i].dealPayTime);
				} else {
					this.detailData[i].dealPayTime = 0;
				}
			}
			for (var i = 0; i < time.length; i++) {
				for (var j = i + 1; j < time.length; j++) {
					if (time[i] == time[j]) { //第一个等同于第二个，splice方法删除第二个
						time.splice(j, 1);
						j--;
					}
				}
			}
			for (var i = 0; i < time.length; i++) {
				this.time_sales.income.push([time[i], 0, 0]);
			}
			// console.log(this.time_sales.income);
			for (var i = 0; i < this.detailData.length; i++) {
				if (this.time_sales.showDate == parseInt(this.detailData[i].payTime.substr(5, 2)) * 100 + parseInt(this.detailData[
						i].payTime.substr(8, 2))) {
					for (var j = 0; j < this.time_sales.income.length; j++) {
						if (this.time_sales.income[j][0] == this.detailData[i].dealPayTime) {
							this.time_sales.income[j][2] += this.detailData[i].price;
							this.time_sales.income[j][1]++;
						}
					}
				}
			}
			for (var i = 0; i < this.time_sales.income.length; i++) {
				if (this.time_sales.maxTimes < this.time_sales.income[i][1]) {
					this.time_sales.maxTimes = this.time_sales.income[i][1];
				}
			}
			this.make_time_sales();
		},
		make_time_sales() {
			//    第四个图表消费时间分布
			var time_sales = echarts.init(document.getElementById('time_sales'));

			// 指定图表的配置项和数据
			var time_sales_option = {
				title: {
					text: Math.floor(vueData.$data.time_sales.showDate / 100) + '月' + vueData.$data.time_sales.showDate % 100 + '日' +
						'消费时间分布',
					x: 'center'
				},
				tooltip: {
					trigger: 'item',
					formatter: function(obj) {
						var value = obj.value;
						return "时间：" + value[0] + '<br>次数' + value[1] + '<br>收入' + value[2];
					}
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data: vueData.$data.time_sales.type
				},
				xAxis: {
					type: 'value',
					name: '时间',
					max: 24,
					min: 0,
					nameLocation: 'middle',
					nameTextStyle: {
						color: 'black',
						fontSize: 18
					},
					splitLine: {
						show: false
					},
					axisLine: {
						lineStyle: {
							color: 'black'
						}
					},
					axisLabel: {
						formatter: '{value}：00'
					}
				},
				yAxis: {
					type: 'value',
					name: '次数',
					max: vueData.$data.time_sales.maxTimes,
					nameTextStyle: {
						color: 'black',
						fontSize: 18
					},
					axisLine: {
						lineStyle: {
							color: 'black'
						}
					},
					splitLine: {
						show: false
					},
					axisLabel: {
						formatter: '{value} 次'
					}
				},
				series: [{
					name: '次数',
					type: 'scatter',
					data: vueData.$data.time_sales.income,
					itemStyle: {
						emphasis: {
							shadowBlur: 24,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.8)'
						}
					},
					symbolSize: function(val) {
						return val[2] / 4;
					},
					color: function(val) {
						var colors = ['#bcd3bb', '#e88f70', '#edc1a5', '#9dc5c8', '#e1e8c8', '#7b7c68', '#e5b5b5', '#f0b489',
							'#928ea8', '#bda29a'
						];
						return colors[val.dataIndex % colors.length];
					}
				}],
			}
			// 使用刚指定的配置项和数据显示图表。
			time_sales.setOption(time_sales_option);
			//    ------------------------------------------------------------------
		},
		get_staff_sales() {
			// console.log(this.detailData);
			var stuffId = [];
			for (var i = 0; i < this.detailData.length; i++) {
				stuffId.push({
					'userId': this.detailData[i].userId,
					'staffName': this.detailData[i].staffName
				});
			}
			for (var i = 0; i < stuffId.length; i++) {
				for (var j = i + 1; j < stuffId.length; j++) {
					if (stuffId[i].userId == stuffId[j].userId) { //第一个等同于第二个，splice方法删除第二个
						stuffId.splice(j, 1);
						j--;
					}
				}
			}
			for (var i = 0; i < stuffId.length; i++) {
				this.staff_sales.type.push(stuffId[i].staffName + '\nID:' + stuffId[i].userId);
				this.staff_sales.income[0].push(0);
				this.staff_sales.income[1].push(0);
				for (var j = 0; j < this.detailData.length; j++) {
					if (this.detailData[j].userId == stuffId[i].userId) {
						this.staff_sales.income[0][i]++;
						this.staff_sales.income[1][i] += this.detailData[j].price;
					}
				}
			}
			this.make_staff_sales();
		},
		make_staff_sales() {
			//    第五个图表员工贡献
			var staff_sales = echarts.init(document.getElementById('staff_sales'));

			// 指定图表的配置项和数据
			var staff_sales_option = {
				color: ['#003366', '#4cabce'],
				legend: {
					data: ['服务次数', '创造收益']
				},
				title: {
					text: "近期员工贡献"
				},
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'cross',
						crossStyle: {
							color: '#999'
						}
					}
				},
				xAxis: [{
					type: 'category',
					axisTick: {
						show: false
					},
					data: vueData.$data.staff_sales.type,
					axisPointer: {
						type: 'shadow'
					}
				}],
				yAxis: [{
						type: 'value',
						min: 0,
						max: Math.ceil(Math.max.apply(null, vueData.$data.staff_sales.income[0]) / 10) * 10,
					},
					{
						type: 'value',
						min: 0,
						max: Math.ceil(Math.max.apply(null, vueData.$data.staff_sales.income[1]) / 10) * 10,
					}
				],
				series: [{
					name: '服务次数',
					type: 'bar',
					barGap: 0,
					data: vueData.$data.staff_sales.income[0]
				}, {
					name: '创造收益',
					type: 'bar',
					barGap: 0,
					yAxisIndex: 1,
					data: vueData.$data.staff_sales.income[1]
				}]
			}
			// 使用刚指定的配置项和数据显示图表。
			staff_sales.setOption(staff_sales_option);
		},
		get_day_sales() {
			this.$http.get(httpUrl + '/turnover?size=366', {
				params: {
					"endTime": this.today.year + "-" + this.today.month + "-" + this.today.day + " 24:00:00",
					"startTime": this.weekday.year + "-" + this.weekday.month + "-" + this.weekday.day + " 00:00:00"
				}
			}).then(res => {
				// console.log(res.body.data.records);
				if (res.body.success) {
					var data = res.body.data.records;
					for (var i = 0; i < 7; i++) {
						this.day_sales.type[i] = String(new Date(new Date().getTime() - (6 - i) * 24 * 3600 * 1000).getFullYear()) +
							"-" + String(new Date(new Date().getTime() - (6 - i) * 24 * 3600 * 1000).getMonth() + 1) + "-" + String(new Date(
								new Date().getTime() - (6 - i) * 24 * 3600 * 1000).getDate());
					}
					// console.log(this.day_sales);
					for (var i = 0; i < data.length; i++) {
						for (var j = 0; j < this.day_sales.type.length; j++) {
							if (this.day_sales.type[j] == data[i].date.substr(0, 10)) {
								this.day_sales.income[j] += data[i].moneyIncome;
							}
						}
					}
				}
				this.make_day_sales();
			}).catch(err => {
				console.log(err);
			})
		},
		make_day_sales() {
			//    第六个图表每日销售
			var day_sales = echarts.init(document.getElementById('day_sales'));

			// 指定图表的配置项和数据
			var day_sales_option = {
				// color: ['#4cabce'],
				color:function(val) {
						var colors = [ '#bcd3bb', '#e88f70', '#edc1a5', '#9dc5c8', '#e1e8c8', '#7b7c68', '#e5b5b5', '#f0b489',
							'#928ea8', '#bda29a'];
						if(val.dataIndex<7){
							return '#4cabce';
						}
						else{
							return colors[val.dataIndex % colors.length];
						}
					},
				legend: {
					data: ['收入']
				},
				title: {
					text: "近期收入"
				},
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'cross',
						crossStyle: {
							color: '#999'
						}
					}
				},
				xAxis: [{
					type: 'category',
					axisTick: {
						show: false
					},
					data: this.day_sales.type,
					axisPointer: {
						type: 'shadow'
					}
				}],
				yAxis: [{
					type: 'value',
					min: 0,
					max: Math.ceil(Math.max.apply(null, this.day_sales.income) / 10) * 10,
				}],
				series: [{
					name: '收入',
					type: 'bar',
					barGap: 0,
					data: this.day_sales.income
				}, ]
			}
			// 使用刚指定的配置项和数据显示图表。
			day_sales.setOption(day_sales_option);
		},
		add_day_sales() {
			if (this.add_date) {
				console.log(this.add_date);
				this.$http.get(httpUrl + '/turnover?size=366', {
					params: {
						"endTime": this.add_date + " 24:00:00",
						"startTime": this.add_date + " 00:00:00"
					}
				}).then(res => {
					if (res.body.success) {
						var data = res.body.data.records;
						this.day_sales.type.push(this.add_date);
						this.day_sales.income.push(0);
						// console.log(this.day_sales.type);
						for (var i = 0; i < data.length; i++) {
							// for (var j = 7; j < this.day_sales.type.length; j++) {
								if (this.day_sales.type[this.day_sales.type.length-1] == data[i].date.substr(0, 10)) {
									this.day_sales.income[this.day_sales.type.length-1] += data[i].moneyIncome;
								}
							// }
						}
						// console.log(this.day_sales);
						this.make_day_sales();
					}
				})
			} else {
				alert("请选择时间!");
			}
		},
	},
});

//echarts图表实现
$(function() {
	//第一个图表
	var myChart = echarts.init(document.getElementById('left_echarts'));

	// 指定图表的配置项和数据
	var option = {
		title: {
			text: '2077年销量'
		},
		tooltip: {},
		legend: {
			data: ['销量']
		},
		xAxis: {
			data: ["一月", "二月", "三月", "四月", "五月", "六月"]
		},
		yAxis: {},
		series: [{
			name: '销量',
			type: 'bar',
			data: [5, 20, 36, 10, 10, 20]
		}]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
	//    ------------------------------------------------------------------

	//    第二个图表
	var myChart = echarts.init(document.getElementById('right_echarts'));

	// 指定图表的配置项和数据
	var option = {
		title: {
			text: '产品销售量',
			x: 'center'
		},
		tooltip: {
			trigger: 'item',
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'vertical',
			left: 'left',
			data: ['产品A', '产品B', '产品C', '产品D', '产品E']
		},
		series: [{
			name: '产品销量',
			type: 'pie',
			radius: '55%',
			center: ['50%', '60%'],
			data: [{
					value: 335,
					name: '产品A'
				},
				{
					value: 310,
					name: '产品B'
				},
				{
					value: 234,
					name: '产品C'
				},
				{
					value: 135,
					name: '产品D'
				},
				{
					value: 1548,
					name: '产品E'
				}
			],
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
	myChart.setOption(option);
})

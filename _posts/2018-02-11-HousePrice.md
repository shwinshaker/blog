---
title: House Price Prediction
author: Shwin
layout: post
category: Internship
---

<h3> <center> 深圳房价预测——基于宏观数据 </center> </h3>
 
<h1 style="text-align: center; margin-top: 1.0em"> 数据清洗和特征选择 </h1>

<p style="font-size: 1.0em"> —— 房价指数 </p>

&emsp;&emsp;首先对**深圳房产交易数据**做一个基本的了解。此数据集包含销售时间自2008年4月20日至2017年9月24日的房产交易记录共约40万条，其中销售价格有效（不为0）的交易记录共231,262条，对有效销售价格做一统计直方图可得*图1* 。可以清楚地看到，大部分房价处于每平米1万到3万之间，随后随着价格升高而呈阶梯型地下降。此直方图将房价最高和最低的1%数据都分别归作了一类，因此在靠近0和超过14万每平米处有两个较高的分布。  
<p style="text-align: center">
	<img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpocmccnplj30p00acdfx.jpg" width="100%">
	<font size="2"> <I> 图 1 房屋销售价格统计直方图 </I> </font>
</p>

<!-- [comment]: # (![图 1 房屋销售价格统计直方图]) -->

&emsp;&emsp;依据房价的分布，*图2* 将房价比较正常的部分（小于14万每平米）与房屋的建筑面积作了一散点图，可以看到建筑面积集中在100平米左右，这也与预期相符。仔细观察*图2* 还可以发现横向和纵向的条状分布，纵向分布是比较好理解的，因为通常一种户型下的建筑面积类似，而价格则因为其所处的位置，买卖方市场等因素而会有较大不同；横向分布则是房价不变而建筑面积变化的情况，又发现几条明显的横向带的房价都是80,000，100,000，120,000等整数，猜想可能是房子的销售人员根据心理预期而对某一区域没有标定价格的房子做的简单填充，不过这当然与接下来的分析关系不大。另外，从*图2*中也可以看到，当房屋面积近似小于100平米时，房价和面积关系不大，而当面积大于100平米时，则房价与面积有相对明显的正相关。前者是属于比较小的户型，也是市场中需求最大的部分，这时房价基本受其区位因素决定。而后者，即当房屋面积很大时，房价和面积有正相关也是可以理解的。

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws1.sinaimg.cn/large/006tNc79ly1fpp4c4kg8sj30jq0fmt9w.jpg" width="50%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 2 房价与建筑面积散点图 </I> </font>
	</p>
</center>


&emsp;&emsp;接下来看一下房价分布中异常的部分，即房价最高和最低的1%。其中最高的1%分布为从每平米15万到每平米超过100万，这显然不太符合常理，确实，在最高的那部分(*图3*)出现了许多横向的带状直线，且价格基本都为整数，故仍然猜想是销售人员对数据进行的手动填充或改正。

<!-- <figure class="half">
    <img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpp4ek9l3sj30jw0gj74i.jpg">
    <img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp4ej00kyj30jq0gu746.jpg">
</figure> -->

<!-- <center class="half">
	<p>
		<p style="margin-bottom: 0pt">
			<img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpp4ek9l3sj30jw0gj74i.jpg" width="40%">
		</p>
		<p>
			<font size="2"> <I> 图 2 房价与建筑面积散点图 </I> </font>
		</p>
	</p>
	<p>
	    <p style="margin-bottom: 0pt">
			<img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp4ej00kyj30jq0gu746.jpg" width="40%">
		</p>
		<p>
			<font size="2"> <I> 图 2 房价与建筑面积散点图 </I> </font>
		</p>
    </p>
</center> -->
<!-- <center>
	<font size="2"> <I> 图 2 房价与建筑面积散点图 </I> </font>
	<font size="2"> <I> 图 2 房价与建筑面积散点图 </I> </font>
</center>> -->

<table width="100%" style="margin-bottom: 0pt">
	<tr>
		<td>
			<center>
				<img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpp4ek9l3sj30jw0gj74i.jpg" border="0" width="100%">
				<font size="2"> <I> 图 3 房价最高的1%数据的房价与面积关系 </I> </font>
			</center>

		</td>
		<td>
			<center>
				<img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp4ej00kyj30jq0gu746.jpg" border="0" width="100%">
				<font size="2"> <I> 图 4 房价最低的1%数据的房价与面积关系 </I> </font>
			</center>
		</td>
</tr></table>

&emsp;&emsp;在房价最低的那部分中(*图4*)中，房价集中在每平米1元，6元和10元三个区域，且都为横向带状线。据此基本可以认为这部分数据是不真实的。

&emsp;&emsp;综上，房价数据中存在相当多的异常值，因此为了得到比较合理的房价指数，首先将房价数据中最高和最低的1%数据去掉，也就是每平米价格大于146,667元和小于641元的数据将被直接丢弃，然后按照房子的销售时间，按月求其中位数，这样可以得到自2008年至2017年共10年间以月为基本间隔的房价指数，如*图5*。注意中间有些月会缺乏有效的销售数据，直接置为0显然是不合理的，这里直接采用最简单的一阶线性插值，根据其相邻月份的房价指数计算缺失月的指数。

<!-- <p style="text-align: center">
	<img src="https://ws2.sinaimg.cn/large/006tNc79ly1fpp4f35f8dj30q308y74w.jpg" width="100%">
	<font size="2"> <I> 图 1 房屋销售价格统计直方图 </I> </font>
</p> -->
<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws2.sinaimg.cn/large/006tNc79ly1fpp4f35f8dj30q308y74w.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 5 房价指数随时间的变化及每月房价数据的分档分布。房价指数单位为元每平方米。 </I> </font>
	</p>
</center>

&emsp;&emsp;上图显示自2008年以来，房价基本处于攀升态势，并在合理范围内存在小范围的波动。但是注意在2016年9月，房价指数出现了剧烈的下滑，前一个月房价中位数还在4万以上，这个月则骤降至1万以下，这似乎不太正常。为了找出原因，将每月纳入考量的房产交易数据以1万以下，1万到10万，10万以上三个区间做分类统计。可以看到自2011年以后大部分房价都在1万以上，但在2016年9月却突然出现超过2500套低于1万元每平米的房子进入销售，由此拉低了此月的整体房价中位数。更细节的考察可以发现，这一个月的异常数据是由一个名为“正大同堂”的房产项目引起的。如果只将此项目名下的所有房产交易数据根据每月中位数和分类分布做一统计(见*图6*)，可以清楚地看到在2016年9月此项目上马了超过2500套均价在8000元每平的房产，而其他月份则几乎没有销售记录。简单的网络调查可以发现此项目确实在2016年9月左右在龙岗区雁田水库以南新开了均价相当低的一个楼盘，并很快销售一空。虽然这部分数据造成了整体房价指数的异常，但其终究是有效的房价数据，因此直接刨去是不合适的，姑且先留在这里，对整体的房价趋势应该不会有太大的影响。
<p style="text-align: center">
	<img src="https://ws1.sinaimg.cn/large/006tNc79ly1fpp4f0klflj30q308umx9.jpg" width="100%">
	<font size="2"> <I> 图 6 项目名为“正大同堂”的房价数据的中位数统计和分档分布 </I> </font>
</p>

<p style="font-size: 1.0em; margin-top: 2.0em"> —— 宏观经济数据 </p>

&emsp;&emsp;下面来对宏观经济数据做一些清洗和补充。对现有宏观数据进行提取和整合后共可得到34个特征。将每个特征的数据和房价指数的时间区间作对应后，统计对每个特征的有效数据，连同房价指数列表如下。

<table style="line-height: 0.6em; margin-bottom: 0pt">
    <tr style="background-color: #aaa; color: white">
        <td></td>
        <td>特征名</td>
        <td>单位</td>
        <td>特征代号</td>
        <td>有效数据个数</td>
    </tr>
    <tr>
        <td>0</td>
        <td>房价指数</td>
        <td>元/月</td>
        <td>Price</td>
        <td>114</td>
    </tr>
    <tr>
        <td>1</td>
        <td>房地产投资</td>
        <td>/年</td>
        <td>HouseInvest</td>
        <td>10</td>
    </tr>
    <tr>
        <td>2</td>
        <td>施工房屋面积</td>
        <td>/年</td>
        <td>HouseBuiltArea</td>
        <td>10</td>
    </tr>
    <tr>
        <td>3</td>
        <td>房屋销售面积</td>
        <td>/年</td>
        <td>HouseSoldArea</td>
        <td>10</td>
    </tr>
    <tr>
        <td>4</td>
        <td>房屋销售价格</td>
        <td>/年</td>
        <td>HouseSoldPrice</td>
        <td>10</td>
    </tr>
    <tr>
        <td>5</td>
        <td>购置土地面积</td>
        <td>/年</td>
        <td>LandAcquiredArea</td>
        <td>10</td>
    </tr>
    <tr>
        <td>6</td>
        <td>常住人口</td>
        <td>万人/年</td>
        <td>ResidentPopulation</td>
        <td>10</td>
    </tr>
    <tr>
        <td>7</td>
        <td>非户籍人口</td>
        <td>万人/年</td>
        <td>NonRegisteredPopulation</td>
        <td>10</td>
    </tr>
    <tr>
        <td>8</td>
        <td>户籍人口</td>
        <td>万人/年</td>
        <td>RegisteredPopulation</td>
        <td>8</td>
    </tr>
    <tr>
        <td>9</td>
        <td>房产税税收收入</td>
        <td>万元/年</td>
        <td>Housetax</td>
        <td>9</td>
    </tr>
    <tr>
        <td>10</td>
        <td>国内生产总值(深圳)</td>
        <td>万元/年</td>
        <td>GDP</td>
        <td>10</td>
    </tr>
    <tr>
        <td>11</td>
        <td>人均国内生产总值(深圳)</td>
        <td>元/年</td>
        <td>GDPPerCapita</td>
        <td>10</td>
    </tr>
    <tr>
        <td>12</td>
        <td>成交土地数量</td>
        <td>宗/月</td>
        <td>DealLandNum</td>
        <td>108</td>
    </tr>
    <tr>
        <td>13</td>
        <td>成交土地占地面积</td>
        <td>万平方米/月</td>
        <td>DealLandArea</td>
        <td>108</td>
    </tr>
    <tr>
        <td>14</td>
        <td>供应土地数量</td>
        <td>宗/月</td>
        <td>SupplyLandNum</td>
        <td>108</td>
    </tr>
    <tr>
        <td>15</td>
        <td>供应土地占地面积</td>
        <td>万平方米/月</td>
        <td>SupplyLandArea</td>
        <td>108</td>
    </tr>
    <tr>
        <td>16</td>
        <td>CPI累计同比</td>
        <td>/月</td>
        <td>CPIAddRatio</td>
        <td>121</td>
    </tr>
    <tr>
        <td>17</td>
        <td>CPI累计同比(居住)</td>
        <td>/月</td>
        <td>CPIDwellAddRatio</td>
        <td>109</td>
    </tr>
    <tr>
        <td>18</td>
        <td>CPI环比(居住)</td>
        <td>/月</td>
        <td>CPIDwellChainRatio</td>
        <td>109</td>
    </tr>
    <tr>
        <td>19</td>
        <td>CPI同比(居住)</td>
        <td>/月</td>
        <td>CPIDwellRatio</td>
        <td>121</td>
    </tr>
    <tr>
        <td>20</td>
        <td>CPI环比</td>
        <td>/月</td>
        <td>CPIChainRatio</td>
        <td>109</td>
    </tr>
    <tr>
        <td>21</td>
        <td>CPI同比</td>
        <td>/月</td>
        <td>CPIRatio</td>
        <td>121</td>
    </tr>
    <tr>
        <td>22</td>
        <td>在岗职工平均工资</td>
        <td>元/年</td>
        <td>Salary</td>
        <td>10</td>
    </tr>
    <tr>
        <td>23</td>
        <td>平均每户家庭人口</td>
        <td>人</td>
        <td>FamilyMemberNum</td>
        <td>21</td>
    </tr>
    <tr>
        <td>24</td>
        <td>人均可支配收入</td>
        <td>元/三月(累计)</td>
        <td>Income</td>
        <td>22</td>
    </tr>
    <tr>
        <td>25</td>
        <td>人均消费性支出</td>
        <td>元/三月(累计)</td>
        <td>Expenditure</td>
        <td>22</td>
    </tr>
    <tr>
        <td>26</td>
        <td>商品住宅成交金额</td>
        <td>亿元/月</td>
        <td>DealHouseSum</td>
        <td>108</td>
    </tr>
    <tr>
        <td>27</td>
        <td>商品住宅成交面积</td>
        <td>万平方米/月</td>
        <td>DealHouseArea</td>
        <td>108</td>
    </tr>
    <tr>
        <td>28</td>
        <td>商品住宅成交均价</td>
        <td>元/平方米</td>
        <td>DealHousePrice</td>
        <td>108</td>
    </tr>
    <tr>
        <td>29</td>
        <td>出生人数(广东)</td>
        <td>万人/年</td>
        <td>BirthNumber</td>
        <td>9</td>
    </tr>
    <tr>
        <td>30</td>
        <td>出生率(广东)</td>
        <td>/年</td>
        <td>BirthRatio</td>
        <td>10</td>
    </tr>
    <tr>
        <td>31</td>
        <td>M0</td>
        <td>亿元/月</td>
        <td>M0</td>
        <td>121</td>
    </tr>
    <tr>
        <td>32</td>
        <td>M1</td>
        <td>亿元/月</td>
        <td>M1</td>
        <td>121</td>
    </tr>
    <tr>
        <td>33</td>
        <td>M2</td>
        <td>亿元/月</td>
        <td>M2</td>
        <td>121</td>
    </tr>
    <tr>
        <td>34</td>
        <td>出台限购政策</td>
        <td>是/否</td>
        <td>PurchaseRestriction</td>
        <td>145</td>
    </tr>
    <tr>
        <td></td>
    </tr>
</table>

&emsp;&emsp;可以很明显地看到，有相当多的特征严重缺乏数据，并且其采样频率也与房价指数所给出的以月为频率不符。由此，需要对数据进行重采样和内插值。注意有一些数据是一段时间的累计值，在插值过程中要注意将其转化为累计分布然后再做差分。将全部数据重采样为月，并使用三次样条内插后，可以得到初步的宏观数据。

<p style="text-indent: 2em">
然而此时仍有相当多的数据缺乏较新的值，例如2017年到现在的部分，若仍然使用样条插值进行外插不能得到合理的结果。这里采用简单的机器学习方法，对每个特征进行自回归训练，预测其尾部的缺失数据。经过试验，以2-4年的数据为窗口进行预测是比较好的，具体模型可以使用多层感知机(MLP)，隐藏层(Hidden Layer)通常取1-2层，神经元数量和输入层神经元数量基本相当，为了防止过拟合，还可以加入一些Drop out层，优化器选择Adam效果更好，具体的训练参数对各个特征稍有不同。将训练过程的大纲罗列如下：
</p>

<ul style="font-size: 12pt; line-height: 1.5em">
	<li style="margin-left: 2.0em"> 视情况做差分处理以消去总趋势 </li>
	<li style="margin-left: 2.0em"> 将数值标准化 </li>
	<li style="margin-left: 2.0em"> 重新整理数据以转化为监督学习问题 </li>
	<li style="margin-left: 2.0em"> 搭建模型并训练，交叉验证以评估模型 </li>
	<li style="margin-left: 2.0em"> 对缺失数据逐个预测，将预测值代入旧的缺失值以预测新数据 </li>
	<li style="margin-left: 2.0em"> 转换数据到原来的格式 </li>
</ul>


&emsp;&emsp;经过自回归预测，所有特征的尾部缺失值都可以被填满，而头部缺失值则简单地做等值外插，因为其对整个预测过程影响不大。将原始数据，样条内插数据和经过自回归预测后的数据做一对比图见于*图7*。注意标有“Cum”的子图表示该特征与时长有关，因此首先做了累积之后再插值到月，并且画图时也是使用的累计值(若不用累计值作图，则原来以年为单位的数值将是以月为单位的数值的约12倍，作图上感觉不一致，影响对插值性能的判断)。当然仍有一些特征累计插值后数据和原始数据点不重合，这是因为将累积值插值再差分后第一个数据被丢掉了，因此再次累积并作图的时候，插值后的数据会低于原始数据一个定值，此定值即原始数据的第一个数据点。简单地将第一个数据点重新放入插值后的数据是不合理的，因为它的频率还是原来的频率，而不是重采样后的频率。

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp88onbgvj30oj0ufq6d.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 7 宏观经济特征的原始数据，内插数据和机器学习预测数据对比。<br/>黄色散点为原始数据点，蓝色曲线为经过三次样条内插后的数据，绿色曲线为基于插值数据进行机器学习后的预测 </I> </font>
	</p>
</center>

<p style="font-size: 1.0em; margin-top: 2.0em"> —— 特征选择 </p>

&emsp;&emsp;下面考虑选择哪些特征进入最后的训练。首先给出各特征之间及各特征和作为目标的房价指数之间的相关性。常用的Pearson相关系数矩阵见于*图8*。

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp88naxqnj30qu0qwadj.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 8 各特征之间的相关系数矩阵 </I> </font>
	</p>
</center>

&emsp;&emsp;为了方便比较，将所有特征与目标房价指数间的相关性做了一个排序，由上到下，由左到右相关性逐渐减低，因此相关性高的特征都集中于左上角。由于横轴和纵轴都做了相同的排序，因此此矩阵是关于对角线对称的。可以明显看到左上角一个较大的区域内的特征相关性都非常高，相关系数在0.9左右，具体特征包括货币量(M0，M1，M2)、GDP、人口、平均收入和房地产投入等，这些特征都是宏观经济状态的表现形式，因此相互之间比较相关也是可以理解的。另外，和房价指数相关性最高的两个特征是“商品住宅成交均价”和“房屋销售价格”，相关系数都接近0.9，考虑到这两个特征实际上和房价指数意义重叠，若引入训练似乎不合常理，因此这里将这两个特征舍去。

&emsp;&emsp;- **to-do: 主成分分析**

&emsp;&emsp;下面使用Xgboost回归器对特征做简单的回归训练，以得到每个特征的重要性，见于*图9*。图中按照重要性由高到低排序，同时也给出了各特征和目标房价指数间的相关系数，以供对比。可以看到隶属于房地产完成指标的1-5号特征对分类的贡献最大，除去直接反映房价的房屋销售价格，其他4个指标与房地产市场投资、供需情况等密切相关，因此显然会直接影响到房价。另外也可以看到，特征的贡献大小和其与目标指数的相关性并无直接关系。
<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws2.sinaimg.cn/large/006tNc79ly1fpp88lw1l1j30q30kugmd.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 9 特征重要性及其对应的和目标指数的相关性 </I> </font>
	</p>
</center>
 
<!-- ------------------------------------------------------------------------------------
 -->

<h1 style="text-align: center; margin-top: 3.0em"> 模型训练和评估 </h1>
<p style="font-size: 1.0em; margin-top: 0em"> —— 建立模型 </p>

&emsp;&emsp;下面建立模型来预测最关键的房价指数。房价预测作为一个时间序列问题，采用LSTM模型是合理的。准备训练的过程和对特征进行自回归预测相似，罗列如下：

<ul style="font-size: 12pt; line-height: 1.5em">
	<li style="margin-left: 2.0em"> 将整合后的数据标准化，这里采用0 - 1的区间 </li>
	<li style="margin-left: 2.0em"> 将数据矩阵转化为有滞后时间步的监督学习问题，这里采用当月及前48个月的特征数据来预测某个月的房价指数，即共49个时间步。注意前几个月的房价本身也会对预测房价有贡献，因此需加入自回归的一项，这样每个时间步的特征总数为33个 </li>
	<li style="margin-left: 2.0em"> 划分训练集和测试集，选取2016年6月1日以后的房价指数作为测试集，这样至少在训练中可以避开在当年9月出现的房价指数异常点 </li>
	<li style="margin-left: 2.0em">建立LSTM模型，输入层为固定的33个单元，隐藏层为23个单元，输出层为47个单元，增加一层Drop out以防止过拟合，最后以一个线性的全连接层输出预测结果。所有LSTM单元的激活函数都为默认的tanh函数</li>
</ul>

&emsp;&emsp;以上建立了一个含有49个时间步及33个输入特征的递归网络。


<p style="font-size: 1.0em; margin-top: 2.0em"> —— 评估和预测 </p>

&emsp;&emsp;下面训练模型，训练时不设Batch，Epoch在400以上，这样得到训练集误差(平均绝对误差)和测试集误差见于*图10*。

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws2.sinaimg.cn/large/006tNc79ly1fpp88l47kmj30ep0b10sx.jpg" width="60%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 10 LSTM学习曲线 </I> </font>
	</p>
</center>

&emsp;&emsp;最后，根据已训练的模型逐一预测缺失值，并将预测值代入到新的缺失值的预测中。然后将数据矩阵转换回每月特征和指标对应的形式，并依靠标准化函数将其对应到真实的房价指数数值。这样可以预测得到自2017年10月到2020年的房价指数，与真实值对比图见于*图11*。

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws1.sinaimg.cn/large/006tNc79ly1fpp88k21hej30q507v3ys.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 10 LSTM学习曲线 </I> </font>
	</p>
</center>

&emsp;&emsp;图中黑色曲线即真实数据，而蓝色曲线及其红色外延曲线表示预测值，以红色标出是为了表示没有真实值做对照。红色虚线之前的部分为训练集，之后的部分为测试集。可以看到模型还是有比较强的泛化能力，除去出现在2016年9月的异常值外，测试集中的预测值基本与真实值相符。

&emsp;&emsp;根据此预测，房价在2016年年末达到峰值并开始下降，持续下跌到2018年年末后会有小幅反弹。新近的房地产房价情况基本与此相符。

<p style="font-size: 1.0em; margin-top: 2.0em"> —— 模型解释 </p>

&emsp;&emsp;滑动相关系数 体现预测趋势的好坏

<center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpp88koi5uj30q10dvmxs.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 12 预测值和期望值的滑动相关系数，滑动窗口为10个数据点 </I> </font>
	</p>
</center>

&emsp;&emsp; - **to-do: 残差分析**

&emsp;&emsp; - **to-do: 使用lime解释模型——效果不佳**

因为使用了scale，所以看不到原数据  
4年前的建设用地对房价影响很大吗？

 <center>	
	<p style="margin-bottom: 0pt">
		<img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpp955m8stj30q30eat9b.jpg" width="100%">
	</p>
	<p style="margin-top: 0pt">
		<font size="2"> <I> 图 13 使用lime对第8个test数据点进行解释 </I> </font>
	</p>
</center>




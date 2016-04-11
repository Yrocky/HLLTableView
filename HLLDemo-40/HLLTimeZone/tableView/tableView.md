##1.第一阶段

> 需要的知识
> 	1.UITableView的基本使用
> 	2.NSTimeZone的基本使用(时区的获取)
> 	3.排序的简单使用


####主要目的
	
对UITableView能够进行简单、基础的使用。

对使用何种UITableView类型(Plain、Group)、何种结构(UITableViewController、UIViewController+UITableView)、何种编程方式(纯代码、IB界面)不做要求，但是针对以上所提及的一些方式都要能够很熟练的运用。

####Demo要求

* 要求将所有读取出来的时区使用列表进行展示

效果如下，

![image](Basice.png)

####具体分析

对于时区类[NSTimeZone](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSTimeZone_Class/#//apple_ref/occ/clm/NSTimeZone)的使用做一个简单的介绍，这个不是重点。


```
+ (NSArray<NSString *> *)knownTimeZoneNames;

Returns an array of strings listing the IDs of all the time zones known to the system.
```

`+knownTimeZoneNames`方法用于获取目前已知的所有时区的ID，是一个装载着字符串类型的数据，其中的字符串格式如下`Africa/Luanda`,表示所在州的时区，有的地区可能还会有第三个，比如`America/North_Dakota/Beulah`

从获取的已知时区列表中可以看出，所有的时区ID都是按照A-Z升序排列的，但是以防万一，还是要求对其进行A-Z的升序排列。


##2.第二阶段

> 需要的知识
>	1.对UITableView的Group类型的使用
>	2.使用对象模型来表征数据
>	3.排序的进一步使用
>	4.UITableView的主要数据源方法，以及某些特定的使用场景下的方法

####主要目的

进一步学习对UITableView的使用，使用模型数据进行具体数据的存储，并通过模型数据对UITableView进行数据源配置

####Demo需求

* 对已知的时区(TimeZone)按照不同地区(Region)进行展示
* 同一个地区下展示相同的时区

![image](Region.png)

#### 具体分析

每一个具体的时区都是一个单独的数据，但是他们都是时区，从面相对象的角度来说，他们是同一种类(Class)中的不同实例对象(Object)，所以我们可以使用NSObject来表示时区这种数据类型。

同时，每一个时区又有其所属的区域，也就是从`+knownTimeZoneNames`方法获得的时区ID中`/`分隔的第一个字符串。

所以这里使用两个对象模型进行时区数据的表征
	
* 时区区域----Region
* 具体时区----TimeZoneWrapper


#### 一个需求

现在要求不是按照地区进行Section划分，对所有的时区进行重新的排序。要求所有时区按照A...Z升序进行排序，以每一个时区的首字母进行Section划分，同时要求有侧边栏索引。注，使用`UITableViewDataSource-sectionIndexTitlesForTableView`方法。

效果如下，

![image](A-Z Section Index.png)

##### 新需求的要求

* 使用现阶段所学的知识完成上面的新需求，可以在原有工程上进行修改也可以另建工程
* 不能使用硬编码

硬编码就比如直接写上A...Z这26个字母这之类的代码，这样照成的后果就是有可能有的字母是不会出现的，但是这个索引还是出现在表格视图中，所以要按照实际的数据进行效果实现。


####实现方式

一般进行字母排序会有两种情况(在中国)：
	
	1. 第一种是有中文的数据，比如电话本中
	2. 另一种是没有中文纯英文单词的数据，比如这个时区列表

这里不考虑有中文字符出现的情况，那个比较复杂，仅仅考虑全部是英文字符的情况。



##3.第三阶段
>需要的知识
1.自定义UITableViewCell
2.协议-代理模式


#### 主要目的

使用自定义的UITableViewCell的子类进行完全自定义的表格视图界面，并能够实现QQ好友列表的组折叠效果，即点击SectionView可以控制该Section下的Cell的展示与隐藏---抽屉效果。

#### Demo需求
* 可以按照要求进行自定义的Cell
* 分别使用纯代码和IB进行Cell的自定义
* 实现点击Cell下的状态视图
* 使用合理的方案完成抽屉效果


#### 具体分析

要实现自定义的Cell就需要知道UITableViewCell在UITableView中的展示规则，在UITableView进行滑动的是时候，滑动前所有屏幕上可见的Cell在退出屏幕之后就进入重用池，即将展现的新Cell会使用放入重用池中的Cell，但是由于他们的展示数据是不一样的，所以这里就需要在创建Cell之后进行数据的配置，


##4.第四阶段
>需要的知识
1.UITableView和UISearchViewController的结合使用
2.UISearchView的使用
3.谓词的使用

#### 主要目的

掌握UISearchView以及与其相关类的使用，并能够合理的与UITableView进行结合使用，使用谓词进行数据的过滤，达到搜索的目的。

#### Demo要求
* 将UISearchViewController的UISearchView作为UITableView的tableViewHeaderView
* 点击搜索框可以进行搜索内容，按照输入的字符进行检索是否有匹配的时区，并展示在表格视图中
* 如果没有相应的搜索内容应提供一个视图对用户进行提示

#### 具体分析



##5.第五阶段
>需要的知识
1.UITableView的主要数据域方法
2.协议-代理模式
3.UITabbarController


#### 主要目的

使用UITabbarContrller展示根据不同要求进行排列的时区信息，同一个UITableView在不同的数据源方法下进行不同的

#### Demo要求

* 提供如下四种不同的数据源：
	* 第一种是阶段一中的最基础的效果
	* 第二种是按照不同地区进行Section的时区排列效果
	* 第三种是按照A-Z进行Section的时区排列效果
	* 第四种是自定义Cell并且按照不同地区进行Section的时区排序效果
* 使用一个UITableView，而不是四个UITableView，
	

#### 具体分析


##6.第六阶段


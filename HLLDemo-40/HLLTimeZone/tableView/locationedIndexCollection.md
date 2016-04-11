
# 更加便捷的表视图索引----UILocatioinedIndexCollection


通常使用UITableView来展示一些具有相同的数据，但是当屏幕中的数据比较多的时候，一个实际场景是通讯录列表，成千上百的通讯录信息，如果要查找比较靠后的通讯信息，就需要疯狂的滑动屏幕直到到达自己需要的区域。这不是一个很好的用户体验，应该说是一个很糟糕的用户体验，当然在通讯录信息比较少的时候他还不会体现出来，但是身为开发人员应该提前意识到这个问题的存在，并在开发解决。

!<---more--->

那么如何解决这个问题从而优化用户体验呢？以下有几个基础的解决方案：

* 第一个，使用类似于QQ好友列表那样，将具有相同属性的数据归为一个Section，然后提供这个SectionHeaderView可以打开关闭，

* 第二个，为该UITableView提供一个UISearchBar在其头部，通过用户输入的关键字进行数据的筛选，具体可以看手机通讯录界面。

* 第三个，提供侧边栏`区域索引标题`，也就是纵向排列的字母，具体可以看手机通讯录界面。

其他的解决办法可以是以上几种结合着使用，这里只针对于第三种方法进行一个扩展，也是对UILocatioinedIndexCollection的一个学习。


### 为什么使用UILocalizedIndexedCollation

当使用第三种方法的时候需要实现一个数据源方法：`-sectionIndexTitlesForTableView:`，另外一个方法可选`-tableView:sectionForSectionIndexTitle:atIndex: `。


可以自己动手去生成这个字母列表，这是一个比较正确且传统的办法，优点是可以按照实际的数据获得字母列表，缺点就是还要自己处理逻辑以及针对于不同的地区的字母列表可能还需要做本地化适配。


那能否找到一个智能的类，能够提供字母排序，并且还可以很方便的完成本地化操作？这时候就提现出来一个新的功能类，用来进行提供快速索引---[UILocalizedIndexedCollation](https://developer.apple.com/library/prerelease/ios/documentation/iPhone/Reference/UILocalizedIndexedCollation_Class/index.html#//apple_ref/doc/uid/TP40008302)，他是一个单例，通过`+currentCollection`就可以获得对象，他的作用是**根据地区来生成与之对应的区域索引标题**.


### 初识UILocalizedIndexedCollation

UILocationIndexCollection提供了两个数组属性用于获取`sectionIndexTitles`和`sectionTitles`，需要注意的是不同地区，sectioinIndexTitles是不同的，英文环境下就是比较常用的“A、B...Z 、#”，其他地区有所差别，具体可以看这个

![locatioinIndexCollectio](locationIndexCollection.png)
{% asset_img locatioinIndexCollection locationIndexCollection.png %}

所以看到这里就应该发现一个问题，不论什么地区使用UILocationedIndexCollection返回的sectionTitles或者sectionIndexTitles都是全部的数据，也就是说是最大集合，但是实际情况中的数据信息有可能是该集合的子集，没有的数据一般是不会显示出来的，这也算是使用UILocatioinedIndexCollection的一个不智能的地方了吧。但是如果还是想使用UILocatioinedIndexCollection，但是数据又不全，那就需要做一些操作甚至在UILocatioinedIndexCollection的基础上封装出来一个更加智能的类，按下不表。


从UILocalizedIndexedCollation提供的方法中可以看出来，他和UITableViewDataSource中的某一些方法是完美结合的：

> -tableView:titleForHeaderInSection:
> -sectionTitles

```
// 返回每一个对应Section的内容
// 如果使用UILocalizedIndexedCollation，可以使用`-sectionTitles`数组中的对象
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [self.collection sectionTitles][section];
}
```

> -sectionIndexTitlesForTableView:
> -sectionIndexTitles

```
// 返回一个区域索引标题的数组，用于在列表右边显示，例如字母序列 A...Z 和 #。注意，区域索引标题很短，通常不能多于两个 Unicode 字符。
// 如果使用UILocalizedIndexedCollation，可以使用`-sectionIndexTitles`方法返回索引数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return [self.collection sectionIndexTitles];
}
```

> -tableView:sectionForSectionIndexTitle:atIndex:
> -sectionForSectionIndexTitleAtIndex:

```
// 返回一个NSInteger类型的值，当点击返回当用户触摸到某个索引标题时列表应该跳至的区域的索引，比如B-1
// 如果使用UILocalizedIndexedCollation，可以通过`-sectionForSectionIndexTitleAtIndex:`方法进行返回点击到侧边栏的字母要跳转到的Section区域
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    return [self.collection sectionForSectionIndexTitleAtIndex:index];
}
```

至于UILocatioinedIndexCollection中余下的两个方法：
> -sectionForObject: collationStringSelector:


和
> -sortedArrayFromArray:collationStringSelector:


```
A selector that identifies a method returning an identifying string 
for object that is used in collation. 

The method should take no arguments and return an NSString object.

For example, this could be a name property on the object.

```

看文档可以发现是用于排序的，两个方法的最后一个参数需要传递一个选择子，必须是`没有参数`，并且`返回值是NSString对象`的方法，因此这里可以使用该对象的一个字符串属性。

第一个是用于排列出对象属于哪一个Section，返回一个NSInteger数据，就是标明该对象属于哪一个Section中。

第二个是用于对某一个Section下的Rows(数组)按照选择子进行排序，返回的是完成排序的SortedRows(数组)。


### 如何使用UILocalizedIndexedCollation

当拿到了装有要展示的、未排序、未分区的对象数组(objectsArray)之后，如何结合UILocalizedIndexedCollation免去排序以及索引的添加呢？需要做的就是讲数据和UILocalizedIndexedCollation进行合理的结合，以便能够在UITableView中显示出来正确的数据，大致上有三步：

* 第一步，获取到所有的Sections数组，这个是根据系统环境固定个数的一个数组，这也是使用UILocalizedIndexedCollation不好的地方

```
    NSInteger sectionTitlesCount = [[UILocalizedIndexedCollation currentCollation] sectionTitles].count;
    
    NSMutableArray * newSectionsArray = [NSMutableArray array];
    
    //  获得所有的sections数组
    for (NSInteger index = 0; index < sectionTitlesCount; index ++) {
        
        NSMutableArray * sections = [NSMutableArray array];
        
        [newSectionsArray addObject:sections];
    }
```

* 第二步，遍历对象数组(objectsArray)，由UILocalizedIndexedCollation决定每一个对象按照选择子应该属于哪一个Section，

```
    for (id object in objectsArray) {
        
        // 获得每个对象所在的section
        NSInteger sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(someProperty)];
        
        // 通过setionNumber取出section数组
        NSMutableArray * secitonObjects = newSectionsArray[sectionNumber];
        
        // 把属于该section的对象放入数组section数组中
        [secitonTimeZones addObject:object];
    }
```

* 第三步，对每一个Section分区下的对象进行排序，通过UILocalizedIndexedCollation来决定，省去了自己写排序逻辑

```
    for (NSInteger index = 0; index < sectionTitlesCount; index ++) {
        
        // 原始的对应section下的数组
        NSArray * objectsArray = newSectionsArray[index];
        
        //  排过序之后的section下的数组
        // 注意这里如果tableView是可以编辑的，就需要使用mutable copy
        NSArray * sortedObjectsArray = [[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsArray collationStringSelector:@selector(someProperty)];
        
        // 替换掉原来的数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedObjectsArray];
    }

```

做完这些之后会发现，UITableViewDataSource方法中的一些重要方法可以实现了，但是到目前为止使用UILocalizedIndexedCollation仅仅还能实现这一个：

> -numberOfSectionsInTableView:

```
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}
```

对于

> -tableView:numberOfRowsInSection:

和

> -tableView:cellForRowAtIndexPath:

这两个重要的方法还是不能实现的，因为这需要知道更加具体的Section内部的数组信息，而不是仅仅使用UILocalizedIndexedCollation的`-sectionTitles`方法获得的SectionTitles，所以需要再引入一个变量，用来持有在三步操作中获得的`newSectionArray`----sectionsArray，以便在别的地方使用。

在第三步之后添加一句

```
    self.sectionsArray = newSectionsArray;
```

现在可以实现那两个数据源方法了：

```

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray * rows = self.sectionsArray[section];
    
    return rows.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSArray * rows = self.sectionsArray[indexPath.section];
    
    id object = rows[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",object.someProperty ? : @" "];

    return cell;
}
```

基本上UILocalizedIndexedCollation的使用就这样了，说的比较繁琐，具体可以参考下面的文章或者例子


参考文章：
---

* [NSHipster](http://nshipster.cn/uilocalizedindexedcollation/)
* [Apple Developer Library](https://developer.apple.com/library/prerelease/ios/documentation/iPhone/Reference/UILocalizedIndexedCollation_Class/index.html#//apple_ref/occ/instm/UILocalizedIndexedCollation)
* [Sample Code:3_SimpleIndexedTableView](https://developer.apple.com/library/prerelease/ios/samplecode/TableViewSuite/Listings/3_SimpleIndexedTableView_SimpleIndexedTableView_APLViewController_m.html#//apple_ref/doc/uid/DTS40007318-3_SimpleIndexedTableView_SimpleIndexedTableView_APLViewController_m-DontLinkElementID_22)

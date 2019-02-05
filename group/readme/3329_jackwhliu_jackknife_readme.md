JackKnife帮助文档![Release](https://jitpack.io/v/JackWHLiu/jackknife.svg)  [![API](https://img.shields.io/badge/API-11%2B-brightgreen.svg?style=flat)](https://android-arsenal.com/api?level=11)
================================
![avatar](http://jackwhliu.cn/static/images/banner3.jpg)

一、环境配置
--------------------------------
在gradle中配置环境。
#### //指定仓库的地址，在project的build.gradle加入粗体字的代码。
<blockquote>
allprojects {
  repositories {
    jcenter()
    <h3>maven { url "https://jitpack.io" }</h3>
  }
}
</blockquote>

#### //依赖本库，在app模块的build.gradle加入加粗的代码，版本号也可改成master-SNAPSHOT直接拿最新代码编译。
<blockquote>
dependencies {
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-ioc:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-orm:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-mvp:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-widget:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-util:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-annotations-ioc:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-ioc2:2.5.14'</h3>
    <h3>compile 'com.github.JackWHLiu.jackknife:jackknife-aop:2.5.14'</h3>
}
</blockquote>

二、如何使用(参考https://github.com/JackWHLiu/JackKnifeDemo)
--------------------------------
### (一)基于IOC依赖注入的自动注入视图、绑定控件和注册事件（jackknife-ioc）
#### 1、自动注入视图（Inject Layout）
##### （1）Activity继承com.lwh.jackknife.app.Activity,Fragment继承com.lwh.jackknife.app.Fragment
##### （2）保证布局的xml文件和Activity和Fragment的Java类的命名遵循一定的映射关系（Java类名必须以Activity或Fragment结尾）。
<blockquote>
    <b>前缀+名字，如activity_main</b>
    例如：MainActivity.java映射的xml文件名就为activity_main.xml，TTSFragment.java映射的xml文件名就为fragment_t_t_s.xml。
    Java文件以大写字母分隔单词，xml以下划线分隔单词。
</blockquote>
 
#### 2、自动绑定控件（Inject Views）
##### （1）不使用注解
> 直接在Activity或Fragment声明控件（View及其子类）为成员变量，不加任何注解。它会以这个View的名字来绑定该控件在xml中的id的value，即@+id/后指定的内容。
##### （2）使用@ViewInject
> 优先级比不加注解高，简单的说，加上这个注解就不会使用默认的使用成员属性名来对应xml的控件id的方式，而是使用该注解指定的id与xml的控件id绑定。
##### （3）使用@ViewIgnore
> 优先级最高，加上该注解，jackknife会直接跳过该控件的自动注入。一般使用在使用Java代码new出来的控件提取到全局的情况。也可以在ViewStub懒加载布局的时候使用。
#### 3、自动注册事件（Inject Events）
>  ）创建一个自定义的事件注解，在这个注解上配置@EventBase，并使用在你要实际回调的方法上，<b>注意保持参数列表跟原接口的某个回调方法的参数列表保持一致</b>。在jackknife-annotations-ioc中也提供了常用的事件的注解，比如@OnClick。

### (二)数据库ORM模块（jackknife-orm）
#### 1、初始化配置
> 继承com.lwh.jackknife.app.Application，并在Application中完成初始化，如果你使用2.0.15+的版本，就当我没说。因为从v2.0.15开始不再需要使用继承的方式。最后调用Orm.init(OrmConfig)完成初始化配置;//调用Orm的init方法
#### 2、完成实体类的编写
> 如果你想使用jackknife-orm自动创表，你只需要实现OrmTable接口再配置一些基本信息即可。
需要注意的是，在一个OrmTable的实现类中，至少要有一个配置主键或外键的属性。
##### （1）@Table
> 配置你要映射的表名
##### （2）@Column
> 配置你要映射的列名
##### （3）@Ignore
> 配置你要跳过映射的列名
##### （4）@PrimaryKey
> 配置主键
##### （5）@Check
> 配置检查条件
##### （6）@Default
> 配置默认值
##### （7）@Unique
> 配置唯一约束
##### （8）@NotNull
> 配置非空约束
#### 3、创表
> 以User为例，TableManager.createTable(User.class);//创建OrmTable的实现类的表，创表一般在初始化配置时完成，因为这样可以在表结构改变时，自动更新。
> 如果在第一步中使用了OrmConfig的创表配置config.tables()，则不需要此步骤。
#### 4、API大全
> 首先要获取到操作该表的DAO对象，以User为例
OrmDao&lt;User&gt; dao = DaoFactory.getDao(User.class);

| 名称 | 所在类 | 描述 | 
| - | :-: | - | 
| insert(T bean) | OrmDao| 单条插入，插入一条数据 | 
| insert(List&lt;T&gt; bean) | OrmDao| 多条插入，插入一些数据 | 
| deleteAll() | OrmDao | 删除所有数据 | 
| delete(WhereBuilder builder) | OrmDao | 按条件删除数据 |
| update(WhereBuilder builder) | OrmDao | 按条件修改数据 |
| selectOne() | OrmDao | 查询第一条数据 |
| selectOne(QueryBuilder builder) | OrmDao | 查询最符合条件的一条数据 |
| select(QueryBuilder builder) | OrmDao | 按条件查询数据 |
| selectAll() | OrmDao | 查询所有数据 |
| selectCount() | OrmDao | 查询数据的条数 |
| selectCount(QueryBuilder builder) | OrmDao | 查询符合条件数据的条数 |
| createTable(Class&lt;? extends OrmTable&gt; tableClass) | TableManager | 创建一张表 |
| dropTable(Class&lt;? extends OrmTable&gt; tableClass) | TableManager | 删除一张表 |
| upgradeTable(Class&lt;? extends OrmTable&gt; tableClass) | TableManager | 升级一张表 |

### (三)基于MVP设计理念的开发（jackknife-mvp）
#### 1、所需要依赖的类
##### （1）BaseModel（M层）
> 它是一个强大的数据筛选器，可以支持多条件筛选。
##### （2）IBaseView（V层）
> 在继承这个接口的接口中提供与界面显示相关的操作，比如显示某某数据，或获取从控件中获取用户输入的结果。建议继承这个
接口的接口也以I开头命名，避免与自定义View混淆。
##### （3）BasePresenter（P层）
> 在presenter中持有view和model的引用，它的职责是处理业务层的操作，如把model中的数据加载到view上显示、文件下载等。耗时操作务必在presenter中完成，jackknife-mvp可以有效防止activity的内存泄漏。
##### （4）BaseActivity或BaseFragment（V层）
> 比如public class MainActivity extends BaseActivity<IMainView, MainPresenter> implements
IMainView。你可以用jackknife提供的com.lwh.jackknife.mvp.BaseActivity，也可以参考它自己来实现。
#### 2、注意点
> 关于mvp这种架构，市面上众说纷纭，有支持的，也有不支持的。总之，mvp既有优点，也有缺点。先说优点，解除模型数据和UI显示的耦合，界面显示和业务操作逻辑分离，易于创建副本，提高可维护性。缺点也是显而易见的，Presenter和View类爆炸的问题很严重，也就是说，如果你只需要写一个很小的项目，是完全没有必要使用mvp的。当然，个人建议你在业务变化大的界面上使用mvp，而在一些简单的界面（如SplashActivity启动页）上没有必要使用。

### (四)高可扩展性的面向切面编程AOP（jackknife-aop）
> 如果你需要在一组相似的业务需求前后添加相同的业务流程处理，比如百度云盘上传文件的一系列流程，有校验MD5值，如果之前已经被记录了，就可以秒传。以及识别一些非法的文件等。而这些业务可能会在以后发生变化，但是你上传文件的地方太多了，导致牵一发而动全身，到处都要改，这是很不好的。最好的编程体验就是高内聚、低耦合，要改，也是在少数的一两个类上面改。

三、博客（绿色通道）
--------------------------------
简书 : https://www.jianshu.com/u/8f43e6fd56db, https://www.jianshu.com/u/f408bdadacce
CSDN : http://blog.csdn.net/yiranaini_/

四、Demo安装
--------------------------------
http://www.jackwhliu.cn/apks/JackKnifeDemo-v2.5.4.apk

五、官方直播APP
--------------------------------
http://www.jackwhliu.cn/apks/jkplayer.apk

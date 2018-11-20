-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 
-- 服务器版本: 5.5.53
-- PHP 版本: 7.2.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `mybolg`
--

-- --------------------------------------------------------

--
-- 表的结构 `articleinfo`
--

CREATE TABLE IF NOT EXISTS `articleinfo` (
  `artid` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `id` int(11) NOT NULL COMMENT '用户id',
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `author` varchar(50) NOT NULL COMMENT '作者名字',
  `like` int(11) NOT NULL DEFAULT '0' COMMENT '点赞次数',
  `collect` int(11) NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `watch` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `tag` text NOT NULL COMMENT '标签类型数组',
  `type` int(11) NOT NULL COMMENT '文章类型',
  `length` int(11) NOT NULL COMMENT '文章长度',
  `ctime` int(11) NOT NULL COMMENT '发表时间',
  PRIMARY KEY (`artid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `articleinfo`
--

INSERT INTO `articleinfo` (`artid`, `id`, `title`, `content`, `author`, `like`, `collect`, `comment`, `watch`, `tag`, `type`, `length`, `ctime`) VALUES
(1, 1, '这是我的第一篇文章', '<p><span style="font-weight: bold;">开心。</span><br></p><p><span style="font-weight: bold;">相信不久后，这个网站久能跟大家分享了~</span><img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/pcmoren_tian_org.png" alt="[舔屏]" data-w-e="1"></p>', 'fhk', 0, 0, 0, 0, '吹水,首发,测试', 0, 282, 1540257739),
(2, 1, '这是我的第一篇文章', '<p><span style="font-weight: bold;">开心。</span><br></p><p><span style="font-weight: bold;">相信不久后，这个网站久能跟大家分享了~</span><img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/pcmoren_tian_org.png" alt="[舔屏]" data-w-e="1"></p>', 'fhk', 3, 2, 0, 67, '吹水,首发,测试', 0, 282, 1540257804),
(3, 1, '这是我的第一篇文章', '<p><span style="font-weight: bold;">开心。</span><br></p><p><span style="font-weight: bold;">相信不久后，这个网站久能跟大家分享了~</span><img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/pcmoren_tian_org.png" alt="[舔屏]" data-w-e="1"></p>', 'fhk', 2119, 3, 0, 10, '吹水,首发,测试', 0, 282, 1540258190),
(11, 1, '111', '<p>aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&nbsp;</p>', 'fhk', 1, 0, 0, 4, '1,', 0, 109, 1540262713),
(12, 1, '111', '<p>aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&nbsp;</p>', 'fhk', 0, 0, 0, 0, '1,', 0, 109, 1540262724),
(13, 1, '1', '<p>阿斯顿顶顶顶顶顶阿斯顿顶顶顶顶顶 阿斯顿顶顶顶顶顶阿斯顿顶顶顶顶顶阿斯顿顶顶顶顶顶阿斯顿顶顶顶顶顶&nbsp;</p>', 'fhk', 0, 0, 0, 0, '1,', 0, 158, 1540263040);

-- --------------------------------------------------------

--
-- 表的结构 `articlelist`
--

CREATE TABLE IF NOT EXISTS `articlelist` (
  `id` int(11) NOT NULL COMMENT '用户id',
  `artid` int(11) NOT NULL COMMENT '文章id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `articlelist`
--

INSERT INTO `articlelist` (`id`, `artid`) VALUES
(1, 1),
(1, 2),
(1, 11),
(1, 12),
(1, 13),
(1, 3);

-- --------------------------------------------------------

--
-- 表的结构 `articlemsg`
--

CREATE TABLE IF NOT EXISTS `articlemsg` (
  `id` int(11) NOT NULL COMMENT '用户id',
  `artid` int(11) NOT NULL COMMENT '文章id',
  `commentid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` text NOT NULL COMMENT '评论内容',
  `rep` int(11) NOT NULL DEFAULT '0' COMMENT '回复',
  `ctime` int(11) NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`commentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='保存文章评论的列表' AUTO_INCREMENT=21 ;

--
-- 转存表中的数据 `articlemsg`
--

INSERT INTO `articlemsg` (`id`, `artid`, `commentid`, `content`, `rep`, `ctime`) VALUES
(0, 0, 1, '111', 0, 1540459692),
(0, 0, 2, '', 0, 1540459939),
(0, 0, 3, '', 0, 1540460007),
(0, 0, 4, '', 0, 1540460142),
(0, 0, 5, '', 0, 1540520449),
(0, 0, 6, '', 0, 1540520465),
(0, 0, 7, '', 0, 1540520517),
(0, 0, 8, '', 0, 1540520534),
(1, 2, 9, '<p>加油！</p><p>你是最胖的！<img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e2/xhrnew_baiyan_org.png" alt="[小黄人白眼]" data-w-e="1"></p>', 0, 1540520603),
(1, 2, 10, '<p>加油！</p><p>你是最胖的！<img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e2/xhrnew_baiyan_org.png" alt="[小黄人白眼]" data-w-e="1"></p>', 0, 1540520681),
(1, 2, 11, '<p><br></p>', 0, 1540520697),
(1, 2, 12, '<p><br></p>', 0, 1540520946),
(1, 2, 13, '<p>拉拉 德玛西亚</p>', 0, 1540521243),
(1, 2, 14, '<p>拉拉 德玛西亚</p>', 0, 1540521247),
(1, 2, 16, '<p>我想了很多，还是说点什么吧<img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8e/jiqimaodaxiong_org.gif" alt="[大熊]" data-w-e="1"></p>', 0, 1540529074),
(1, 3, 18, '<p>对不起</p>', 0, 1540529712),
(1, 3, 19, '<pre><code>&lt;div data-v-59947e42="" class="user-content"&gt;&lt;div data-v-59947e42="" class="msg-header"&gt;&lt;a data-v-59947e42="" href="#/personal/1" class="user-name"&gt;fhk&lt;/a&gt; &lt;span data-v-59947e42="" class="ctime"&gt;2018-10-26 / 12:55:12&lt;/span&gt; &lt;span data-v-59947e42="" class="msg-top"&gt;#1&lt;/span&gt;&lt;/div&gt; &lt;div data-v-59947e42="" class="msg-body"&gt;&lt;p&gt;对不起&lt;/p&gt;&lt;/div&gt; &lt;div data-v-59947e42="" class="msg-footer"&gt;&lt;a data-v-59947e42="" href="#"&gt;回复&lt;/a&gt;&lt;/div&gt;&lt;/div&gt;</code></pre><p><br></p>', 0, 1540530629),
(4, 2, 20, '<p>我也留留言~~<img src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b2/xhrnew_buxie_org.png" alt="[小黄人不屑]" data-w-e="1"></p>', 0, 1540543685);

-- --------------------------------------------------------

--
-- 表的结构 `userinfo`
--

CREATE TABLE IF NOT EXISTS `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id 唯一',
  `username` varchar(30) NOT NULL COMMENT '用户姓名',
  `nickname` varchar(30) NOT NULL COMMENT '昵称',
  `telphone` int(11) NOT NULL COMMENT '电话',
  `qq` int(11) NOT NULL DEFAULT '0' COMMENT 'QQ',
  `wechat` varchar(30) NOT NULL DEFAULT '0' COMMENT '微信',
  `email` varchar(30) NOT NULL DEFAULT '0' COMMENT '邮箱',
  `image` varchar(300) NOT NULL DEFAULT '../../../static/images/userimg/user_mr.jpg' COMMENT '用户头像',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `ctime` int(11) NOT NULL COMMENT '注册时间',
  `ltime` int(11) NOT NULL COMMENT '最后登录时间',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '金币数量',
  `sign` int(11) NOT NULL DEFAULT '0' COMMENT '签到次数',
  `article` int(11) NOT NULL DEFAULT '0' COMMENT '发表文章数量',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `getcomment` int(11) NOT NULL DEFAULT '0' COMMENT '获得评论次数',
  `like` int(11) NOT NULL DEFAULT '0' COMMENT '点赞次数',
  `getlike` int(11) NOT NULL DEFAULT '0' COMMENT '获得点赞次数',
  `follow` int(11) NOT NULL DEFAULT '0' COMMENT '关注数量',
  `fans` int(11) NOT NULL DEFAULT '0' COMMENT '粉丝数量',
  `motto` varchar(100) NOT NULL DEFAULT '这家伙很懒，什么都没有留下' COMMENT '座右铭<个性签名>',
  `collect` int(11) NOT NULL DEFAULT '0' COMMENT '收藏文章数量',
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户详细信息表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `userinfo`
--

INSERT INTO `userinfo` (`id`, `username`, `nickname`, `telphone`, `qq`, `wechat`, `email`, `image`, `birthday`, `ctime`, `ltime`, `price`, `sign`, `article`, `comment`, `getcomment`, `like`, `getlike`, `follow`, `fans`, `motto`, `collect`) VALUES
(1, 'fhk', 'FHK', 2147483647, 215537936, 'FHK255', 'hk255@foxmail.com', '@/../static/images/userimg/user_2.jpg', 0, 1540530752, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, '坑要一个个填，步要一步步走。', 0),
(2, 'admin', '超级管理员', 0, 0, '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(4, '255', '陈小姐', 2147483647, 0, '0', '0', '../../../static/images/userimg/user_mr.jpg', 0, 1540540725, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '这家伙很懒，什么都没有留下', 0),
(3, '255', '', 0, 0, '0', '0', '../../../static/images/userimg/user_mr.jpg', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '这家伙很懒，什么都没有留下', 0);

-- --------------------------------------------------------

--
-- 表的结构 `userlist`
--

CREATE TABLE IF NOT EXISTS `userlist` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '用户id 唯一',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` varchar(30) NOT NULL COMMENT '密码',
  `phone` int(11) NOT NULL COMMENT '手机号码',
  `image` varchar(300) NOT NULL DEFAULT '../../../static/images/userimg/user_3.jpg' COMMENT '用户头像',
  `ctime` int(11) NOT NULL COMMENT '创建时间(时间戳)',
  `admin` int(4) NOT NULL DEFAULT '0' COMMENT '0:普通用户，1:会员，6:管理员，99:超级管理员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户保存用户注册基本信息' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `userlist`
--

INSERT INTO `userlist` (`id`, `username`, `password`, `phone`, `image`, `ctime`, `admin`) VALUES
(1, 'fhk', '123456', 0, '../../../static/images/userimg/user_2.jpg', 1540530752, 99),
(2, 'admin', '123456', 0, '../../../static/images/userimg/user_3.jpg', 0, 0),
(3, 'test', '123456', 0, '../../../static/images/userimg/user_3.jpg', 0, 0),
(4, '255', '123456', 2147483647, '../../../static/images/userimg/user_3.jpg', 1540540725, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

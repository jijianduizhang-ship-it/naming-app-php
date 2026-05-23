mysqldump: [Warning] Using a password on the command line interface can be insecure.
-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: name_imoons_cn
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','$2b$12$cBQNjfaIjETnOcjy8Jxl1eyNO0r6ClTM/CfOhQMo1Nye6W7Tj1wd2','2026-05-13 02:51:38');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL,
  `value` text,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES (1,'ai_api_url','https://api.deepseek.com/v1/chat/completions','2026-05-13 02:45:37'),(2,'ai_api_key','sk-782a13fdf039404c97b59ccb8ec2b959','2026-05-23 03:04:16'),(3,'ai_model','deepseek-chat','2026-05-23 08:34:26');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_articles`
--

DROP TABLE IF EXISTS `knowledge_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `summary` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文章摘要',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容（富文本HTML）',
  `cover_image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '封面图URL',
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `views` int(11) DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) DEFAULT '0' COMMENT '点赞数',
  `is_featured` tinyint(4) DEFAULT '0' COMMENT '是否精选',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：0下架 1上架',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='起名知识文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_articles`
--

LOCK TABLES `knowledge_articles` WRITE;
/*!40000 ALTER TABLE `knowledge_articles` DISABLE KEYS */;
INSERT INTO `knowledge_articles` VALUES (1,'宝宝起名的八大禁忌','仅更新摘要字段','<p>宝宝起名是每个家庭都非常重视的事情，一个好的名字能够影响孩子的一生。以下是起名时需要避免的禁忌：</p><p><strong>一、忌用祖先名讳</strong></p><p>起名不应使用祖先的名字中的字，否则会被视为对祖先的不敬。</p><p><strong>二、忌用生僻字</strong></p><p>生僻字不仅难以书写和输入，还可能影响人际交往。</p>','','',63,5,1,1,'2026-05-23 09:40:22','2026-05-23 16:15:35'),(2,'五行与名字的关系','五行学说在起名中的应用，如何根据八字五行来选择合适的名字。','<p>五行学说是中国传统文化的核心组成部分，与名字的关系密不可分。</p>','','',49,3,1,1,'2026-05-23 09:40:22','2026-05-23 21:06:52'),(3,'女孩优雅名字推荐-已更新','部分更新-仅改摘要','<p>更新后的女孩名字正文内容</p>','','',169,12,1,1,'2026-05-23 09:40:22','2026-05-23 17:00:28'),(7,'测试文章','摘要','<p>正文内容测试</p>','','测试',0,0,0,1,'2026-05-23 18:00:04','2026-05-23 18:00:04');
/*!40000 ALTER TABLE `knowledge_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `name_records`
--

DROP TABLE IF EXISTS `name_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `name_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `surname` varchar(10) NOT NULL,
  `gender` varchar(10) DEFAULT 'boy',
  `birthday` varchar(20) DEFAULT '',
  `name` text NOT NULL,
  `source` varchar(20) DEFAULT 'local',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `name_records`
--

LOCK TABLES `name_records` WRITE;
/*!40000 ALTER TABLE `name_records` DISABLE KEYS */;
INSERT INTO `name_records` VALUES (1,'测试','boy','2024-01-15','{\"bazi\":{\"year\":\"癸卯\",\"month\":\"乙丑\",\"day\":\"戊寅\",\"hour\":\"戊午\",\"wuxing\":{\"木\":2,\"火\":1,\"土\":1,\"金\":0,\"水\":0},\"day_master\":\"戊土\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"浩然\"}]}','ai','2026-05-23 00:30:11'),(2,'重构测试','girl','2024-03-01','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丙寅\",\"day\":\"甲子\",\"hour\":\"庚午\",\"wuxing\":{\"木\":1,\"火\":1,\"土\":1,\"金\":0,\"水\":1},\"day_master\":\"甲木\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"诗涵\",\"meaning\":\"诗意\",\"source\":\"《诗经》\",\"wuxing\":\"水\"}]}','ai','2026-05-23 00:58:50'),(3,'张','boy','2020-01-01','{\"bazi\":{\"year\":\"己亥\",\"month\":\"丙子\",\"day\":\"癸卯\",\"hour\":\"戊午\",\"wuxing\":{\"木\":1,\"火\":1,\"土\":0,\"金\":0,\"水\":2},\"day_master\":\"壬水\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"测试\"}]}','local','2026-05-23 01:27:42'),(4,'赵','girl','2019-05-01','{\"bazi\":{\"year\":\"己亥\",\"month\":\"戊辰\",\"day\":\"戊戌\",\"hour\":\"戊午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":2,\"金\":0,\"水\":1},\"day_master\":\"戊土\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"测试女\"}]}','local','2026-05-23 01:30:45'),(5,'李','男','2024-03-15','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁卯\",\"day\":\"戊寅\",\"hour\":\"戊午\",\"wuxing\":{\"木\":2,\"火\":1,\"土\":1,\"金\":0,\"水\":0},\"day_master\":\"戊土\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"诗涵\"},{\"name\":\"雨晴\"},{\"name\":\"欣怡\"}]}','api_test','2026-05-23 02:06:53'),(6,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":3,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"浩然\",\"meaning\":\"正气广大，胸怀宽广\",\"source\":\"《孟子》\",\"wuxing\":\"水\",\"score\":98},{\"name\":\"明轩\",\"meaning\":\"聪明睿智，气宇轩昂\",\"source\":\"成语\",\"wuxing\":\"土\",\"score\":96},{\"name\":\"思远\",\"meaning\":\"思虑深远，志存高远\",\"source\":\"《诗经》\",\"wuxing\":\"木\",\"score\":95},{\"name\":\"一诺\",\"meaning\":\"一言九鼎，诚实守信\",\"source\":\"成语\",\"wuxing\":\"火\",\"score\":97},{\"name\":\"宇航\",\"meaning\":\"遨游宇宙，探索未知\",\"source\":\"现代\",\"wuxing\":\"土\",\"score\":94},{\"name\":\"子墨\",\"meaning\":\"文房四宝，诗书传家\",\"source\":\"诗词\",\"wuxing\":\"土\",\"score\":92}]}','local','2026-05-23 02:55:57'),(7,'李','boy','2021-02-07','{\"bazi\":{\"year\":\"辛丑\",\"month\":\"庚寅\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":1,\"火\":1,\"土\":2,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"浩然\",\"meaning\":\"正气广大，胸怀宽广\",\"source\":\"《孟子》\",\"wuxing\":\"水\",\"score\":98},{\"name\":\"明轩\",\"meaning\":\"聪明睿智，气宇轩昂\",\"source\":\"成语\",\"wuxing\":\"土\",\"score\":96},{\"name\":\"思远\",\"meaning\":\"思虑深远，志存高远\",\"source\":\"《诗经》\",\"wuxing\":\"木\",\"score\":95},{\"name\":\"一诺\",\"meaning\":\"一言九鼎，诚实守信\",\"source\":\"成语\",\"wuxing\":\"火\",\"score\":97},{\"name\":\"宇航\",\"meaning\":\"遨游宇宙，探索未知\",\"source\":\"现代\",\"wuxing\":\"土\",\"score\":94},{\"name\":\"子墨\",\"meaning\":\"文房四宝，诗书传家\",\"source\":\"诗词\",\"wuxing\":\"土\",\"score\":92}]}','local','2026-05-23 02:59:14'),(8,'李','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":3,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"泽\",\"pinyin\":\"zé\",\"wuxing\":\"水\",\"meaning\":\"恩泽、润泽，寓意福泽深厚，如雨露滋润万物。\",\"source\":\"《孟子·离娄下》“民归之，犹水之就下，沛然谁能御之？”，泽被苍生。\",\"score\":95,\"suitable_reason\":\"五行属水，为宝宝喜用神，可平衡八字中过旺的土，补水调候，助运势通畅。\"},{\"name\":\"铭\",\"pinyin\":\"míng\",\"wuxing\":\"金\",\"meaning\":\"铭记、铭刻，寓意才华出众，名垂青史。\",\"source\":\"《礼记·大学》“汤之盘铭曰：苟日新，日日新，又日新。\",\"score\":93,\"suitable_reason\":\"五行属金，为宝宝喜用神，金能泄土生水，增强命局灵动，利学业事业。\"},{\"name\":\"瀚\",\"pinyin\":\"hàn\",\"wuxing\":\"水\",\"meaning\":\"浩瀚、广瀚，象征胸襟开阔，学识渊博。\",\"source\":\"《淮南子·俶真训》“浩瀚乎不可测”。\",\"score\":94,\"suitable_reason\":\"水行喜用神，补足八字缺水之缺，调候润土，助其性格温润，智慧通达。\"},{\"name\":\"钧\",\"pinyin\":\"jūn\",\"wuxing\":\"金\",\"meaning\":\"古代重量单位，引申为稳重、公正，寓意才华横溢，有担当。\",\"source\":\"《汉书·律历志》“钧者，均也，阳施其气，阴化其形”。\",\"score\":91,\"suitable_reason\":\"金行喜用神，泄土生水，平衡命局，利于事业成就与贵人运。\"},{\"name\":\"澈\",\"pinyin\":\"chè\",\"wuxing\":\"水\",\"meaning\":\"清澈、明澈，寓意心地纯净，思维清晰。\",\"source\":\"《水经注》“水清石出，鱼可数也”，引申为澄澈明净。\",\"score\":92,\"suitable_reason\":\"水行喜用神，补八字之水弱，调候燥土，助其聪明睿智，行事果断。\"},{\"name\":\"锋\",\"pinyin\":\"fēng\",\"wuxing\":\"金\",\"meaning\":\"锋利、锋芒，象征锐意进取，勇往直前。\",\"source\":\"《孙子兵法》“其势险，其节短，势如彍弩，节如发机”，锋锐之象。\",\"score\":90,\"suitable_reason\":\"金行喜用神，泄土生水，增强命局锐气，适合开拓事业，克服土重之滞。\"},{\"name\":\"汐\",\"pinyin\":\"xī\",\"wuxing\":\"水\",\"meaning\":\"夜间的潮汐，寓意生生不息，富有生命力。\",\"source\":\"《海赋》“波如连山，乍合乍散，嘘吸百川，潮汐往来”。\",\"score\":89,\"suitable_reason\":\"水行喜用神，补足命局缺水，调候润泽，助其运势起伏有序，财源广进。\"},{\"name\":\"锐\",\"pinyin\":\"ruì\",\"wuxing\":\"金\",\"meaning\":\"锐利、敏锐，寓意洞察秋毫，才能出众。\",\"source\":\"《考工记》“锐喙决吻”，引申为锋芒毕露，才华横溢。\",\"score\":88,\"suitable_reason\":\"金行喜用神，泄土生水，平衡八字过旺之土，利于学业精进，思维敏捷。\"},{\"name\":\"泓\",\"pinyin\":\"hóng\",\"wuxing\":\"水\",\"meaning\":\"水深而广，比喻胸怀博大，涵养深厚。\",\"source\":\"《说文》“泓，下深貌”，《水经注》中形容水域深邃。\",\"score\":93,\"suitable_reason\":\"水行喜用神，直接补水调候，助其沉淀稳重，化解土重之固执，提升智慧。\"},{\"name\":\"锦\",\"pinyin\":\"jǐn\",\"wuxing\":\"金\",\"meaning\":\"锦绣、华美，寓意前程似锦，生活富足。\",\"source\":\"《诗经·小雅》“锦衾烂兮”，喻美好事物。\",\"score\":87,\"suitable_reason\":\"金行喜用神，泄土生水，增强命局贵气，利于财运与名声，契合生肖鸡（2025年）之金性。\"}]}','ai','2026-05-23 03:22:58'),(9,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":3,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"炅\",\"pinyin\":\"jiǒng\",\"wuxing\":\"火\",\"meaning\":\"光明、火光，象征智慧与温暖\",\"source\":\"《玉篇·火部》：“炅，光也。”\",\"score\":92,\"suitable_reason\":\"火为喜用神，补火生土，助旺日主，寓意前程光明。\"},{\"name\":\"垚\",\"pinyin\":\"yáo\",\"wuxing\":\"土\",\"meaning\":\"山高貌，象征稳固、高大\",\"source\":\"《说文》：“垚，土高也。”\",\"score\":90,\"suitable_reason\":\"土为喜用神，直接补土助身，增强根基，寓意稳重如山。\"},{\"name\":\"烨\",\"pinyin\":\"yè\",\"wuxing\":\"火\",\"meaning\":\"火光盛大，光辉灿烂\",\"source\":\"《诗经·小雅》：“烨烨震电。”\",\"score\":91,\"suitable_reason\":\"火属性补火生土，提升日主能量，寓意才华横溢。\"},{\"name\":\"辰\",\"pinyin\":\"chén\",\"wuxing\":\"土\",\"meaning\":\"星辰、时光，象征希望与生机\",\"source\":\"《诗经·小雅》：“辰彼硕女。”\",\"score\":88,\"suitable_reason\":\"辰为湿土，内藏乙木癸水，但土性助身，且与年柱相呼应，寓意吉祥。\"},{\"name\":\"炯\",\"pinyin\":\"jiǒng\",\"wuxing\":\"火\",\"meaning\":\"光明、明亮，象征洞察力\",\"source\":\"《楚辞·九叹》：“炯炯长夜。”\",\"score\":89,\"suitable_reason\":\"火属性补火，驱寒暖局，助戊土生机，寓意聪慧明理。\"},{\"name\":\"均\",\"pinyin\":\"jūn\",\"wuxing\":\"土\",\"meaning\":\"公平、和谐，象征平衡\",\"source\":\"《说文》：“均，平遍也。”\",\"score\":86,\"suitable_reason\":\"土属性补土助身，调和八字水旺之势，寓意德行高尚。\"},{\"name\":\"炜\",\"pinyin\":\"wěi\",\"wuxing\":\"火\",\"meaning\":\"光彩鲜明，象征辉煌\",\"source\":\"《诗经·邶风》：“彤管有炜。”\",\"score\":90,\"suitable_reason\":\"火属性补火生土，增强日主力量，寓意事业有成。\"},{\"name\":\"坦\",\"pinyin\":\"tǎn\",\"wuxing\":\"土\",\"meaning\":\"平坦、宽广，象征胸怀坦荡\",\"source\":\"《周易·履卦》：“履道坦坦。”\",\"score\":87,\"suitable_reason\":\"土属性补土，助日主稳固，寓意人生顺遂。\"},{\"name\":\"炎\",\"pinyin\":\"yán\",\"wuxing\":\"火\",\"meaning\":\"火光上升，象征热情与活力\",\"source\":\"《说文》：“炎，火光上也。”\",\"score\":88,\"suitable_reason\":\"双火叠加，强力补火生土，中和水寒，寓意积极向上。\"},{\"name\":\"城\",\"pinyin\":\"chéng\",\"wuxing\":\"土\",\"meaning\":\"城墙、城池，象征坚固与守护\",\"source\":\"《诗经·大雅》：“城彼朔方。”\",\"score\":85,\"suitable_reason\":\"土属性补土助身，增强日主抵抗力，寓意意志坚定。\"}]}','ai','2026-05-23 04:12:36'),(10,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":3,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"泽源\",\"pinyin\":\"zé yuán\",\"wuxing\":\"水水\",\"meaning\":\"恩泽广布，源远流长\",\"source\":\"《诗经》‘如川之方至，以莫不增’；成语‘泽深恩重’\",\"score\":95,\"suitable_reason\":\"双水五行，强力补益喜用神水，泄旺金之气，润泽命局，助其聪慧灵动，运势通达。\"},{\"name\":\"沐辰\",\"pinyin\":\"mù chén\",\"wuxing\":\"水土\",\"meaning\":\"如沐春风，星辰闪耀\",\"source\":\"《论语》‘浴乎沂，风乎舞雩’；‘北辰’典故\",\"score\":92,\"suitable_reason\":\"水木相生，沐字补水平衡火金，辰为龙年吉字，暗合年柱甲辰，增强贵气与学识。\"},{\"name\":\"清和\",\"pinyin\":\"qīng hé\",\"wuxing\":\"水土\",\"meaning\":\"清正平和，温润如玉\",\"source\":\"《楚辞》‘扬枹兮拊鼓，疏缓节兮安歌’；成语‘清和平允’\",\"score\":90,\"suitable_reason\":\"清字属水，调和火金相克；和字中和土气，整体使八字流通，性格沉稳而智慧。\"},{\"name\":\"海若\",\"pinyin\":\"hǎi ruò\",\"wuxing\":\"水木\",\"meaning\":\"海纳百川，若谷虚怀\",\"source\":\"《庄子·秋水》‘河伯始旋其面目，望洋向若而叹’\",\"score\":93,\"suitable_reason\":\"海为众水之汇，强力补水；若字属木，泄金生火，平衡命局，寓意胸襟广阔，成就非凡。\"},{\"name\":\"瀚宸\",\"pinyin\":\"hàn chén\",\"wuxing\":\"水金\",\"meaning\":\"浩瀚星空，宸极之尊\",\"source\":\"《文心雕龙》‘浩然见其志’；宸为帝王星\",\"score\":88,\"suitable_reason\":\"瀚水浩荡泄金气，宸字虽金但为吉星，与姓杨木火相合，强化领导力与才华。\"},{\"name\":\"润之\",\"pinyin\":\"rùn zhī\",\"wuxing\":\"水火\",\"meaning\":\"润泽万物，之乎者也\",\"source\":\"《易经》‘云行雨施，品物流形’；成语‘润物无声’\",\"score\":91,\"suitable_reason\":\"润水直接补益喜用神，之字属火引燃丁火，使八字水火既济，智慧与行动力兼备。\"},{\"name\":\"泓森\",\"pinyin\":\"hóng sēn\",\"wuxing\":\"水木\",\"meaning\":\"水深而广，林木繁茂\",\"source\":\"《东观汉记》‘泓宏之声’；《诗经》‘如竹苞矣，如松茂矣’\",\"score\":94,\"suitable_reason\":\"泓水强劲泄金，森木耗土生火，双喜用神全补，化解土金过旺，利事业与健康。\"},{\"name\":\"沛然\",\"pinyin\":\"pèi rán\",\"wuxing\":\"水金\",\"meaning\":\"沛然充沛，自然天成\",\"source\":\"《孟子》‘油然作云，沛然下雨’；成语‘意气沛然’\",\"score\":89,\"suitable_reason\":\"沛水充沛泄金，然字属金但生水，整体助旺水势，使庚金有制，性格刚柔并济。\"},{\"name\":\"洛铭\",\"pinyin\":\"luò míng\",\"wuxing\":\"水金\",\"meaning\":\"洛水之灵，铭记于心\",\"source\":\"曹植《洛神赋》；成语‘铭心镂骨’\",\"score\":87,\"suitable_reason\":\"洛水属水，铭金生水，以金为引助水势，平衡八字中金多，增添文雅与记忆。\"},{\"name\":\"涵宇\",\"pinyin\":\"hán yǔ\",\"wuxing\":\"水土\",\"meaning\":\"涵养深厚，气宇轩昂\",\"source\":\"《周易》‘含章可贞’；成语‘气宇不凡’\",\"score\":90,\"suitable_reason\":\"涵水润局，宇土虽为忌但被水化，整体涵养智慧，使庚金不燥，格局宏大。\"}]}','ai','2026-05-23 05:46:31'),(11,'王','girl','2024-05-20','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"己巳\",\"day\":\"甲申\",\"hour\":\"庚午\",\"wuxing\":{\"木\":0,\"火\":2,\"土\":1,\"金\":1,\"水\":0},\"day_master\":\"甲木\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[]}','local','2026-05-23 05:52:27'),(12,'孙','girl','2025-01-01','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丙子\",\"day\":\"庚午\",\"hour\":\"壬午\",\"wuxing\":{\"木\":0,\"火\":2,\"土\":1,\"金\":0,\"水\":1},\"day_master\":\"庚金\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[]}','local','2026-05-23 05:56:25'),(13,'孙','girl','2025-01-01','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丙子\",\"day\":\"庚午\",\"hour\":\"壬午\",\"wuxing\":{\"木\":0,\"火\":2,\"土\":1,\"金\":0,\"水\":1},\"day_master\":\"庚金\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[]}','local','2026-05-23 05:56:38'),(14,'李','boy','2024-01-27','{\"bazi\":{\"year\":\"癸卯\",\"month\":\"乙丑\",\"day\":\"庚寅\",\"hour\":\"壬午\",\"wuxing\":{\"木\":2,\"火\":1,\"土\":1,\"金\":0,\"水\":0},\"day_master\":\"庚金\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"铭轩\"},{\"name\":\"雨萱\"}]}','local','2026-05-23 07:03:22'),(15,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"甲午\",\"wuxing\":{\"木\":0,\"火\":1,\"土\":3,\"金\":0,\"水\":0},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"泽楷\",\"pinyin\":\"ze kai\",\"wuxing\":\"水木\",\"meaning\":\"泽润万物，楷模风范；水木相生，智慧仁德。\",\"source\":\"《礼记·聘义》‘温润而泽，仁也’；《礼记·缁衣》‘言有物而行有格也’\",\"score\":96,\"suitable_reason\":\"泽属水、楷属木，水木为喜用神，补水耗土，助身平衡，寓意涵养深厚、品行高洁。\"},{\"name\":\"沐宸\",\"pinyin\":\"mu chen\",\"wuxing\":\"水金\",\"meaning\":\"如沐春风，宸宇清朗；水金相生，清贵通达。\",\"source\":\"《诗经·大雅》‘如沐春风’；《文选·西京赋》‘消氛埃于中宸’\",\"score\":94,\"suitable_reason\":\"沐属水、宸属金，水金为喜用神，泄土生水，助调候，寓意润泽清逸、气度不凡。\"},{\"name\":\"泓锦\",\"pinyin\":\"hong jin\",\"wuxing\":\"水金\",\"meaning\":\"泓水深邃，锦绣前程；金水相涵，智勇双全。\",\"source\":\"《水经注》‘泓涵演迤’；《诗经·小雅》‘锦衾烂兮’\",\"score\":93,\"suitable_reason\":\"泓属水、锦属金，金生水为喜用，泄土生金，助身调候，寓意深邃智慧、前程似锦。\"},{\"name\":\"清源\",\"pinyin\":\"qing yuan\",\"wuxing\":\"水木\",\"meaning\":\"清流正源，源远流长；水木相生，根基稳固。\",\"source\":\"《楚辞·渔父》‘举世皆浊我独清’；《诗经·卫风》‘秉心塞渊’\",\"score\":92,\"suitable_reason\":\"清属水、源属木，水木为喜用，补水耗土，助身平衡，寓意清明正直、源远流长。\"},{\"name\":\"铭泽\",\"pinyin\":\"ming ze\",\"wuxing\":\"金水\",\"meaning\":\"铭心刻骨，泽被苍生；金水相生，刚柔并济。\",\"source\":\"《国语·周语》‘铭于心也’；《孟子·滕文公上》‘泽加于民’\",\"score\":91,\"suitable_reason\":\"铭属金、泽属水，金生水为喜用，泄土生水，助身调候，寓意铭记恩泽、仁德济世。\"},{\"name\":\"润之\",\"pinyin\":\"run zhi\",\"wuxing\":\"水金\",\"meaning\":\"润物无声，行之有方；水金相涵，智谋深远。\",\"source\":\"《易·说卦》‘润万物者莫润乎水’；《论语》‘知者行之’\",\"score\":90,\"suitable_reason\":\"润属水、之属金（字形含金），金生水为喜用，泄土生水，助身调候，寓意润泽万物、知行合一。\"},{\"name\":\"浩霖\",\"pinyin\":\"hao lin\",\"wuxing\":\"水木\",\"meaning\":\"浩气长存，甘霖普降；水木相生，胸怀宽广。\",\"source\":\"《孟子·公孙丑上》‘浩然之气’；《诗经·小雅》‘灵雨既零’\",\"score\":89,\"suitable_reason\":\"浩属水、霖属木，水木为喜用，补水耗土，助身平衡，寓意正气浩然、恩泽广布。\"},{\"name\":\"钧泽\",\"pinyin\":\"jun ze\",\"wuxing\":\"金水\",\"meaning\":\"钧天广乐，泽被四方；金水相生，富贵清雅。\",\"source\":\"《列子·周穆王》‘钧天广乐’；《尚书·禹贡》‘泽及枯骨’\",\"score\":88,\"suitable_reason\":\"钧属金、泽属水，金生水为喜用，泄土生水，助身调候，寓意天籁之音、恩泽四方。\"},{\"name\":\"沛宁\",\"pinyin\":\"pei ning\",\"wuxing\":\"水火\",\"meaning\":\"沛然丰沛，宁静致远；水火既济，阴阳调和。\",\"source\":\"《孟子·梁惠王上》‘沛然下雨’；《淮南子·主术训》‘宁静致远’\",\"score\":87,\"suitable_reason\":\"沛属水、宁属火（形含丁火），水为喜用，火为忌但水火既济，可调候润燥，寓意充沛安宁、和谐有度。\"},{\"name\":\"涵清\",\"pinyin\":\"han qing\",\"wuxing\":\"水水\",\"meaning\":\"涵容万物，清正廉明；双水润土，智德双修。\",\"source\":\"《庄子·齐物论》‘注焉而不满，酌焉而不竭’；《诗经·魏风》‘清扬婉兮’\",\"score\":86,\"suitable_reason\":\"涵、清皆属水，双水为喜用，强力补水耗土，助身平衡，寓意包容博大、清正廉洁。\"}]}','ai','2026-05-23 09:14:11'),(16,'李','boy','2024-01-15','{\"bazi\":{\"year\":\"癸卯\",\"month\":\"乙丑\",\"day\":\"戊寅\",\"hour\":\"戊午\",\"wuxing\":{\"木\":2,\"火\":1,\"土\":1,\"金\":0,\"水\":0},\"day_master\":\"戊土\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"明哲\",\"pinyin\":\"Ming Zhe\",\"wuxing\":\"火\",\"meaning\":\"明智睿哲\",\"source\":\"成语\",\"score\":92}]}','test','2026-05-23 09:48:26'),(17,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"己亥\",\"lunar\":\"二〇二四年腊月十八\",\"wuxing\":{\"木\":0,\"火\":0,\"土\":3,\"金\":0,\"水\":1},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"火\",\"土\"],\"avoid\":[\"水\",\"土\"],\"avoidList\":[\"木\",\"金\",\"水\"]},\"names\":[{\"name\":\"沐阳\",\"pinyin\":\"Mù Yáng\",\"wuxing\":\"水木\",\"meaning\":\"如沐春风，阳光普照，寓意在水的滋养下丙火光明温暖。\",\"source\":\"《诗经·蒹葭》\'溯洄从之，道阻且长\'，化用\'沐\'字取润泽之意；阳为日，合丙火之象。\",\"score\":96,\"suitable_reason\":\"沐属水，阳属火，水木相生，助日主丙火，平衡八字土重之势。\"},{\"name\":\"清霖\",\"pinyin\":\"Qīng Lín\",\"wuxing\":\"水木\",\"meaning\":\"清泉甘霖，润物无声，象征才德清正、福泽深厚。\",\"source\":\"《诗经·小雅》\'有冽氿泉，无浸穫薪\'；霖字出《尚书·说命》\'若岁大旱，用汝作霖雨\'。\",\"score\":94,\"suitable_reason\":\"清属水，霖属木，水木齐来，生助丙火，化解土重火晦之弊。\"},{\"name\":\"栩然\",\"pinyin\":\"Xǔ Rán\",\"wuxing\":\"木金\",\"meaning\":\"栩栩如生，自然洒脱，寓意孩子生机勃勃、自在从容。\",\"source\":\"《庄子·齐物论》\'昔者庄周梦为蝴蝶，栩栩然蝴蝶也\'。\",\"score\":91,\"suitable_reason\":\"栩属木，然属金（火生土，土生金，然字下四点属火），木助身，微金制土，整体平衡。\"},{\"name\":\"棠舟\",\"pinyin\":\"Táng Zhōu\",\"wuxing\":\"木水\",\"meaning\":\"棠棣之华，舟行天下，象征兄弟和睦、前程远航。\",\"source\":\"《诗经·召南》\'蔽芾甘棠，勿翦勿伐\'；舟出《易·系辞》\'刳木为舟，剡木为楫\'。\",\"score\":92,\"suitable_reason\":\"棠属木，舟属水，水木相生，补益日主，且木克土以制忌神。\"},{\"name\":\"景行\",\"pinyin\":\"Jǐng Xíng\",\"wuxing\":\"木水\",\"meaning\":\"高山仰止，景行行止，寓意品德高尚、行为光明。\",\"source\":\"《诗经·小雅》\'高山仰止，景行行止\'。\",\"score\":95,\"suitable_reason\":\"景属木（日景生辉），行属水（水流不止），木水助身，且名字气韵高远。\"},{\"name\":\"蔚然\",\"pinyin\":\"Wèi Rán\",\"wuxing\":\"木火\",\"meaning\":\"蔚然成风，文采斐然，期望孩子学识广博、气度不凡。\",\"source\":\"《汉书·叙传》\'蔚然成章\'；又出《诗经》\'菶菶萋萋，雍雍喈喈\'，蔚为草木盛貌。\",\"score\":90,\"suitable_reason\":\"蔚属木，然属火，木火通明，直接生扶丙火日主，增其光彩。\"},{\"name\":\"润之\",\"pinyin\":\"Rùn Zhī\",\"wuxing\":\"水火\",\"meaning\":\"润泽万物，之乎者也，既含水利万物之德，又寓文雅知礼。\",\"source\":\"《礼记·大学》\'富润屋，德润身\'；之字为文言虚词，典雅含蓄。\",\"score\":93,\"suitable_reason\":\"润属水，之属火（形旁丿丶象火），水火既济，平衡八字土重，且润字直接补水。\"},{\"name\":\"柏舟\",\"pinyin\":\"Bǎi Zhōu\",\"wuxing\":\"木水\",\"meaning\":\"柏木为舟，坚韧不拔，象征意志坚定、乘风破浪。\",\"source\":\"《诗经·邶风》\'泛彼柏舟，亦泛其流\'。\",\"score\":91,\"suitable_reason\":\"柏属木，舟属水，水木相生，助身克土，且柏树长青寓意健康。\"},{\"name\":\"涵清\",\"pinyin\":\"Hán Qīng\",\"wuxing\":\"水水\",\"meaning\":\"内涵清正，胸襟广阔，如深潭映月，澄澈明净。\",\"source\":\"《全唐文》\'涵清泉以自洁\'；又出王维诗\'清泉石上流\'。\",\"score\":89,\"suitable_reason\":\"涵属水，清属水，双水强力补益，但需注意勿过，名字整体灵动克土。\"},{\"name\":\"杏林\",\"pinyin\":\"Xìng Lín\",\"wuxing\":\"木木\",\"meaning\":\"杏林春暖，医者仁心，寓含健康、济世之德。\",\"source\":\"三国董奉\'杏林\'典故，后喻医道高明；林出《诗经》\'有杕之杜，生于道左\'。\",\"score\":88,\"suitable_reason\":\"杏属木，林属木，双木成林，强力生火，且木克土，正对身弱土重之症。\"}]}','ai','2026-05-23 11:41:20'),(18,'杨','boy','2025-01-17','{\"bazi\":{\"year\":\"甲辰\",\"month\":\"丁丑\",\"day\":\"丙戌\",\"hour\":\"己亥\",\"lunar\":\"二〇二四年腊月十八\",\"wuxing\":{\"木\":1,\"火\":2,\"土\":4,\"金\":0,\"水\":1},\"day_master\":\"丙火\",\"day_master_strength\":\"身弱\",\"xiyongshen\":[\"木\",\"火\"],\"avoid\":[\"水\",\"土\",\"金\"]},\"names\":[{\"name\":\"景明\",\"pinyin\":\"Jǐng Míng\",\"wuxing\":\"木火\",\"meaning\":\"阳光明媚，前程光明，充满生机与希望。\",\"source\":\"《诗经·小雅·车舝》：“高山仰止，景行行止。” 范仲淹《岳阳楼记》：“春和景明，波澜不惊。”\",\"score\":95,\"suitable_reason\":\"景字五行属木，明字五行属火，木火相生，直接补益日主丙火。寓意宝宝如春日暖阳，光明磊落，前程似锦，符合身弱喜木火的命理需求。\"},{\"name\":\"煜林\",\"pinyin\":\"Yù Lín\",\"wuxing\":\"火木\",\"meaning\":\"如火焰照耀森林，才华横溢，生机勃勃。\",\"source\":\"《诗经·小雅·采芑》：“燁燁震电，不宁不令。” 引申为“煜煜生辉，林海苍茫”。\",\"score\":93,\"suitable_reason\":\"煜字属火，林字属木，木生火旺，强力助益丙火日主。寓意宝宝光芒四射，智慧超群，同时木能生火，增强根基，契合八字喜木火。\"},{\"name\":\"柏然\",\"pinyin\":\"Bǎi Rán\",\"wuxing\":\"木火\",\"meaning\":\"如松柏之坚毅，自然从容，气宇轩昂。\",\"source\":\"《论语·子罕》：“岁寒，然后知松柏之后凋也。” 陶渊明《归去来兮辞》：“木欣欣以向荣，泉涓涓而始流。”\",\"score\":92,\"suitable_reason\":\"柏字属木，然字属火（然本义为燃烧，引申为光明），木火相生。松柏象征坚韧不拔，火代表热情活力，可平衡八字中土重水寒之弊，助丙火日主焕发能量。\"},{\"name\":\"旭尧\",\"pinyin\":\"Xù Yáo\",\"wuxing\":\"火木\",\"meaning\":\"旭日东升，尧天舜日，品德高尚，事业辉煌。\",\"source\":\"《诗经·邶风·旄丘》：“旭日始旦。” 尧为古代圣君，象征仁德与光明。\",\"score\":94,\"suitable_reason\":\"旭字属火，尧字属木（尧从垚，土多但引申为高山，五行归木），木火相生。旭日比喻丙火日主如朝阳初升，尧代表圣贤之德，可化解土重晦火，增强命主贵气。\"},{\"name\":\"荣轩\",\"pinyin\":\"Róng Xuān\",\"wuxing\":\"木火\",\"meaning\":\"荣华富贵，气宇轩昂，事业兴旺。\",\"source\":\"《诗经·小雅·白华》：“荣华始敷。” 曹植《洛神赋》：“轩盖如云。”\",\"score\":91,\"suitable_reason\":\"荣字属木（草木茂盛），轩字属火（轩为高扬之势，五行归火），木生火旺。寓意宝宝生机勃勃、气度不凡，木火之力可助丙火日主摆脱身弱，成就非凡。\"},{\"name\":\"炜桐\",\"pinyin\":\"Wěi Tóng\",\"wuxing\":\"火木\",\"meaning\":\"炜光闪耀，梧桐栖凤，才华出众，高贵祥瑞。\",\"source\":\"《诗经·小雅·巷伯》：“赫赫炎炎，云我无所。” 梧桐引凤典故出自《庄子》及《诗经·大雅·卷阿》。\",\"score\":92,\"suitable_reason\":\"炜字属火，桐字属木（梧桐为木中高贵者），木火相生。炜光象征丙火光辉，梧桐寓意高洁，可补益火势，克制八字寒湿，助宝宝聪慧吉祥。\"},{\"name\":\"松烨\",\"pinyin\":\"Sōng Yè\",\"wuxing\":\"木火\",\"meaning\":\"青松挺立，烨火辉煌，坚毅与热情并存。\",\"source\":\"《论语》松柏后凋之意；《诗经·小雅·十月之交》：“烨烨震电。”\",\"score\":90,\"suitable_reason\":\"松字属木，烨字属火，木火通明。松树象征坚韧长寿，烨火代表光明炽烈，可提升丙火日主能量，应对土重水克之局，使宝宝性格刚柔并济。\"},{\"name\":\"昭林\",\"pinyin\":\"Zhāo Lín\",\"wuxing\":\"火木\",\"meaning\":\"昭明四方，林海浩瀚，胸怀宽广，智慧清明。\",\"source\":\"《诗经·大雅·云汉》：“昭假迟迟。” 《楚辞·九章》：“林深路险。”\",\"score\":91,\"suitable_reason\":\"昭字属火（光明之意），林字属木，木生火旺。昭明象征丙火日主光耀，林代表生机与包容，可平衡八字土重，补足木火，助宝宝智慧开明。\"},{\"name\":\"栩然\",\"pinyin\":\"Xǔ Rán\",\"wuxing\":\"木火\",\"meaning\":\"栩栩如生，自然超脱，充满活力与创意。\",\"source\":\"《庄子·齐物论》：“栩栩然蝴蝶也。” 引申为生动活泼、自由自在。\",\"score\":89,\"suitable_reason\":\"栩字属木（木形），然字属火（燃烧之意），木生火。寓意宝宝灵动鲜活、才华横溢，木火之力可助丙火日主摆脱身弱，激发创造力与生命力。\"},{\"name\":\"炎彬\",\"pinyin\":\"Yán Bīn\",\"wuxing\":\"火木\",\"meaning\":\"炎炎烈火，彬彬有礼，文武兼备，热情儒雅。\",\"source\":\"《诗经·大雅·云汉》：“旱既太甚，蕴隆虫虫。” 彬字出自《论语》“文质彬彬”。\",\"score\":90,\"suitable_reason\":\"炎字属火（双火叠加），彬字属木（木形文雅），火木相生。炎火直接助旺丙火日主，彬木为源，可克土晦火、暖水寒局，使宝宝既有热情又不失儒雅。\"}]}','ai','2026-05-23 11:58:03');
/*!40000 ALTER TABLE `name_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redeem_codes`
--

DROP TABLE IF EXISTS `redeem_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redeem_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `amount` int(11) DEFAULT '0',
  `max_use` int(11) DEFAULT '1',
  `used_count` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  `expired_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redeem_codes`
--

LOCK TABLES `redeem_codes` WRITE;
/*!40000 ALTER TABLE `redeem_codes` DISABLE KEYS */;
INSERT INTO `redeem_codes` VALUES (1,'U3A7ZXY9',10,1,1,1,NULL,0,'2026-05-13 02:54:19'),(2,'JHH8BAMF',50,1,0,1,NULL,0,'2026-05-23 02:08:23'),(3,'MYCODE123',50,5,0,1,NULL,0,'2026-05-23 02:42:46'),(4,'YHRVH9Q4',10,1,1,1,NULL,0,'2026-05-23 02:55:02'),(5,'TESTCODE99',99,1,0,0,NULL,0,'2026-05-23 05:52:27'),(6,'Codetest1',10,1,0,1,NULL,0,'2026-05-23 05:54:50'),(7,'ADMINNEW1',20,5,0,1,NULL,0,'2026-05-23 07:05:01'),(8,'2GWR4DYB',10,1,1,1,NULL,0,'2026-05-23 08:17:15'),(9,'MHUR8TK8',10,1,1,1,NULL,0,'2026-05-23 08:30:43'),(10,'LGBTX84D',1,1,1,1,NULL,0,'2026-05-23 11:39:42'),(11,'YA74XBQ4',10,1,1,1,NULL,0,'2026-05-23 11:40:20'),(12,'TX93476G',10,1,0,1,NULL,0,'2026-05-23 11:40:20'),(13,'KYXBRKAW',10,1,0,1,NULL,0,'2026-05-23 11:40:20');
/*!40000 ALTER TABLE `redeem_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `balance` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-23 22:30:36

/*
Navicat MySQL Data Transfer

Source Server         : 103.235.230.216
Source Server Version : 50719
Source Host           : 103.235.230.216:3306
Source Database       : paymanagerdb

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-11-01 09:23:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for asy_callback_cart_wx
-- ----------------------------
DROP TABLE IF EXISTS `asy_callback_cart_wx`;
CREATE TABLE `asy_callback_cart_wx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `return_code` varchar(32) DEFAULT NULL,
  `return_msg` varchar(200) DEFAULT NULL,
  `appid` varchar(32) DEFAULT NULL,
  `mch_id` varchar(32) DEFAULT NULL,
  `device_info` varchar(32) DEFAULT NULL,
  `nonce_str` varchar(64) DEFAULT NULL,
  `sign` varchar(64) DEFAULT NULL,
  `result_code` varchar(32) DEFAULT NULL,
  `err_code` varchar(32) DEFAULT NULL,
  `err_code_des` varchar(200) DEFAULT NULL,
  `openid` varchar(32) DEFAULT NULL,
  `is_subscribe` varchar(12) DEFAULT NULL,
  `trade_type` varchar(32) DEFAULT NULL,
  `bank_type` varchar(32) DEFAULT NULL,
  `total_fee` double DEFAULT NULL,
  `fee_type` varchar(200) DEFAULT NULL,
  `cash_fee` double DEFAULT NULL,
  `cash_fee_type` varchar(32) DEFAULT NULL,
  `coupon_fee` double DEFAULT NULL,
  `coupon_count` int(11) DEFAULT NULL,
  `transaction_id` varchar(32) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `attach` varchar(150) DEFAULT NULL,
  `time_end` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `isdel` int(11) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `out_trade_no_asy_callback_cart_wx_index` (`out_trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for callback_information_cart_wx
-- ----------------------------
DROP TABLE IF EXISTS `callback_information_cart_wx`;
CREATE TABLE `callback_information_cart_wx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specid` int(11) DEFAULT NULL,
  `prepay_id` varchar(50) DEFAULT NULL,
  `return_code` varchar(32) DEFAULT NULL,
  `return_msg` varchar(200) DEFAULT NULL,
  `result_code` varchar(64) DEFAULT NULL,
  `err_code` varchar(64) DEFAULT NULL,
  `err_code_des` varchar(200) DEFAULT NULL,
  `trade_type` varchar(32) DEFAULT NULL,
  `tele` varchar(20) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `driverid` varchar(32) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `mess` varchar(1500) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `out_trade_no_callback_information_cart_wx_index` (`out_trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for discount_cards
-- ----------------------------
DROP TABLE IF EXISTS `discount_cards`;
CREATE TABLE `discount_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activityId` varchar(32) DEFAULT NULL COMMENT '活动ID',
  `couponsNum` varchar(32) DEFAULT NULL COMMENT '券号码',
  `price` float DEFAULT NULL COMMENT '金额',
  `couponsChannel` varchar(64) DEFAULT NULL COMMENT '优惠券渠道',
  `status` varchar(12) DEFAULT NULL COMMENT '状态',
  `canUseTimes` int(11) DEFAULT '1',
  `usedTimes` int(10) unsigned zerofill DEFAULT NULL COMMENT '已用次数',
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '使用订单',
  `messStatus` int(10) unsigned zerofill DEFAULT NULL COMMENT '短信是否发送1已发送2未发送',
  `emailStatus` int(10) unsigned zerofill DEFAULT NULL COMMENT '邮件是否发送1已发送2未发送',
  `usetime` varchar(32) DEFAULT NULL COMMENT '使用时间',
  `createtime` varchar(32) DEFAULT NULL COMMENT '生成时间',
  `validtime` datetime DEFAULT NULL COMMENT '有效时间',
  `savetime` datetime DEFAULT NULL COMMENT '保存-入库时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=448 DEFAULT CHARSET=utf8mb4 COMMENT='喜乐航X元优惠券';

-- ----------------------------
-- Table structure for dispatchway_list_yl
-- ----------------------------
DROP TABLE IF EXISTS `dispatchway_list_yl`;
CREATE TABLE `dispatchway_list_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `dzp_dispatchWay` int(11) DEFAULT NULL COMMENT 'Integer	是否支持电子票：0.不支持、1.支持',
  `dzp_type` int(11) DEFAULT NULL COMMENT 'dzp_type	dispatchWayList	1	Integer	电子票子类型： 30.电子码（电子码商品没有纸质票）不支持此配送方式时为［-］',
  `dzp_message` varchar(50) DEFAULT NULL,
  `smzq_dispatchWay` int(11) DEFAULT NULL,
  `smzq_address` varchar(50) DEFAULT NULL,
  `smzq_time` varchar(60) DEFAULT NULL,
  `smzq_message` varchar(60) DEFAULT NULL,
  `kdps_dispatchWay` int(11) DEFAULT NULL,
  `kdps_message` varchar(60) DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_productId_dispatchway_list_yl` (`productId`),
  KEY `index_flag_dispatchway_list_yl` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=82533 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for fconfig_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `fconfig_info_yl`;
CREATE TABLE `fconfig_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fconfigId` int(11) DEFAULT NULL COMMENT '分站ID',
  `citycode` varchar(10) DEFAULT NULL COMMENT '城市code',
  `playCity` varchar(20) DEFAULT NULL COMMENT '分站城市名称',
  `playCitySimple` varchar(20) DEFAULT NULL COMMENT '分站城市名称拼音简写',
  `storeAddress` varchar(300) DEFAULT NULL COMMENT '用户上门自取地址',
  `flag` int(11) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_citycode_fconfig_info_yl` (`citycode`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8mb4 COMMENT='查询所有分站接口（getAllFconfig）';

-- ----------------------------
-- Table structure for file_download
-- ----------------------------
DROP TABLE IF EXISTS `file_download`;
CREATE TABLE `file_download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serialNumber` varchar(64) DEFAULT NULL COMMENT 'pad的序列号',
  `macId` varchar(64) DEFAULT NULL COMMENT 'pad的mac地址',
  `sdk_int` int(11) DEFAULT NULL COMMENT '系统API版本',
  `productName` varchar(64) DEFAULT NULL COMMENT '产品名称',
  `deviceName` varchar(64) DEFAULT NULL COMMENT '设备名称',
  `osVersion` varchar(64) DEFAULT NULL COMMENT '系统版本',
  `identification` varchar(64) DEFAULT NULL COMMENT '设备唯一标识',
  `apkVersionName` varchar(64) DEFAULT NULL COMMENT 'Apk版本名称',
  `apkVersionCode` varchar(64) DEFAULT NULL COMMENT 'Apk版本号',
  `airCompany` varchar(64) DEFAULT NULL COMMENT '航空公司',
  `downflag` varchar(32) DEFAULT NULL COMMENT '设备上传时间',
  `status` varchar(32) DEFAULT NULL,
  `exAirCompany` varchar(32) DEFAULT NULL COMMENT '上一个航渠',
  `exApkVersionName` varchar(32) DEFAULT NULL COMMENT '上一个版本信息',
  `timediff` float DEFAULT NULL COMMENT '设备下载时，设备和服务器时间差',
  `firstOpenTime` varchar(20) DEFAULT NULL COMMENT '设备下载apk后第一次打开apk时间',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_download_unique` (`macId`,`apkVersionName`,`airCompany`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=784 DEFAULT CHARSET=utf8mb4 COMMENT='apk下载记录表(HU，8L等)';

-- ----------------------------
-- Table structure for file_upload
-- ----------------------------
DROP TABLE IF EXISTS `file_upload`;
CREATE TABLE `file_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upfilename` varchar(64) DEFAULT NULL COMMENT '上传文件名',
  `upsuccessfilename` varchar(120) DEFAULT NULL COMMENT '上传成功后新文件名',
  `flag` varchar(10) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL COMMENT '版本信息',
  `url` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL COMMENT 'apk版本描述',
  `url_server` varchar(100) DEFAULT NULL,
  `air_version` varchar(32) DEFAULT NULL COMMENT '航渠版本',
  `uploadtime` datetime DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `file_upload_upfilename` (`upfilename`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COMMENT='apk上传记录表';

-- ----------------------------
-- Table structure for goods_info_jxt
-- ----------------------------
DROP TABLE IF EXISTS `goods_info_jxt`;
CREATE TABLE `goods_info_jxt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT NULL,
  `goods_name` varchar(64) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0下架1正常',
  `type` int(11) DEFAULT NULL COMMENT '  //产品类型：1: 普通票，2: 套票，3: 线路',
  `send_type` int(11) DEFAULT NULL COMMENT '发送类型：1: 自动发送；2：管理员审核发送',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付类型：1：在线支付；2：景区到付',
  `amount` int(11) DEFAULT NULL COMMENT '//总库存',
  `sku_user_price` double(15,0) DEFAULT NULL,
  `sku_back_cash` double(15,0) DEFAULT NULL,
  `sku_market_price` double(15,0) DEFAULT NULL,
  `sku_suggest_price` double(15,0) DEFAULT NULL,
  `refund_type` int(11) DEFAULT NULL COMMENT '退票类型：1：允许退票；2：不可退票；3：管理员审核',
  `validity_type` int(11) DEFAULT NULL COMMENT '订单有效期类型：1：订单有效期>0，2：订单有效期 = 0（与产品有效期一致）',
  `validity_day` int(11) DEFAULT NULL COMMENT '  //订单有效期 n：n=0: 不限；产品有效期内均可用；n>0：从预定时间开始起算，在n天内订单可用(不超过产品有效期)',
  `validity_time` bigint(11) DEFAULT NULL COMMENT '//生效时间：数值，下单后经多少时间后可用，按小时计',
  `start_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  `description` longtext,
  `descriptionPath` varchar(100) DEFAULT NULL,
  `brief` varchar(600) DEFAULT NULL COMMENT '产品简介, introduction"',
  `notice` longtext,
  `image` varchar(100) DEFAULT NULL,
  `imagePath` varchar(100) DEFAULT NULL,
  `category_group_name` varchar(32) DEFAULT NULL COMMENT '成人票',
  `last_order_time` bigint(20) DEFAULT NULL,
  `week` varchar(15) DEFAULT NULL,
  `max_num` int(11) DEFAULT NULL,
  `min_num` int(11) DEFAULT NULL,
  `must_id_number` int(11) DEFAULT NULL COMMENT '/身份证类型：0：非必须；1：必须',
  `refund_chanrge_type` int(11) DEFAULT NULL COMMENT ' //退票手续费类型：1: 按票数计算；2：按订单计算，每退一张票需扣手续费 1/票数；',
  `refund_chanrge` double DEFAULT NULL,
  `self_refund_scale` double DEFAULT NULL,
  `self_refund_fixed` double DEFAULT NULL,
  `last_order_date` varchar(16) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1183 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for goods_info_response_kl
-- ----------------------------
DROP TABLE IF EXISTS `goods_info_response_kl`;
CREATE TABLE `goods_info_response_kl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `afterTaxPrice` double DEFAULT NULL,
  `brandCountryName` varchar(32) DEFAULT NULL,
  `brandId` varchar(32) DEFAULT NULL,
  `brandName` varchar(32) DEFAULT NULL,
  `canReturnGoods` int(11) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `detail` varchar(200) DEFAULT NULL,
  `detailStr` longtext,
  `goodsId` varchar(32) DEFAULT NULL,
  `imageUrl` varchar(100) DEFAULT NULL,
  `imageUrlStr` varchar(100) DEFAULT NULL,
  `importType` int(11) DEFAULT NULL,
  `isFreeShipping` varchar(12) DEFAULT NULL,
  `isFreeTax` tinyint(4) DEFAULT NULL,
  `isPostageFree` tinyint(4) DEFAULT NULL,
  `isPresell` tinyint(4) DEFAULT NULL,
  `isSelf` tinyint(4) DEFAULT NULL,
  `leafCategoryId` varchar(32) DEFAULT NULL,
  `logisticsProperty` varchar(32) DEFAULT NULL,
  `marketPrice` double DEFAULT NULL,
  `memberCount` int(11) DEFAULT NULL,
  `onlineStatus` tinyint(4) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `shortTitle` varchar(100) DEFAULT NULL,
  `skuId` varchar(64) DEFAULT NULL,
  `storage` varchar(32) DEFAULT NULL,
  `store` int(11) DEFAULT NULL,
  `subTitle` varchar(200) DEFAULT NULL,
  `suggestPrice` double DEFAULT NULL,
  `taxFees` double DEFAULT NULL,
  `taxRate` double DEFAULT NULL,
  `thirdCategoryId` int(11) DEFAULT NULL,
  `thirdCategoryName` varchar(32) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `warehouseId` varchar(12) DEFAULT NULL,
  `warehouseName` varchar(32) DEFAULT NULL,
  `warehouseStore` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for goods_info_supplier_jxt
-- ----------------------------
DROP TABLE IF EXISTS `goods_info_supplier_jxt`;
CREATE TABLE `goods_info_supplier_jxt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_info_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `info` varchar(100) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `province` int(11) DEFAULT NULL,
  `city_name` varchar(20) DEFAULT NULL,
  `province_name` varchar(20) DEFAULT NULL,
  `lng_lat` varchar(32) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30032 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for goods_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `goods_info_yl`;
CREATE TABLE `goods_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL,
  `priceType` int(11) DEFAULT NULL COMMENT '票价类型（必填）',
  `productPlayid` int(11) DEFAULT NULL COMMENT 'Integer	票价id（必填）',
  `price` float DEFAULT NULL COMMENT '票价金额（必填）',
  `priceNum` int(11) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_goods_info_yl_orderNumber` (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for goods_infor
-- ----------------------------
DROP TABLE IF EXISTS `goods_infor`;
CREATE TABLE `goods_infor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `begintime` varchar(255) DEFAULT NULL,
  `brandid` int(11) DEFAULT NULL,
  `brandname` varchar(255) DEFAULT NULL,
  `categoryid` int(11) DEFAULT NULL,
  `categoryname` varchar(255) DEFAULT NULL,
  `complex_one_pic` varchar(255) DEFAULT NULL,
  `complex_one_pic_source` varchar(255) DEFAULT NULL,
  `complex_pics` varchar(255) DEFAULT NULL,
  `complex_pics_source` varchar(255) DEFAULT NULL,
  `contract_bt` varchar(255) DEFAULT NULL,
  `contract_et` varchar(255) DEFAULT NULL,
  `coordinate` int(11) DEFAULT NULL,
  `detailImagePathItems` varchar(255) DEFAULT NULL,
  `endtime` varchar(255) DEFAULT NULL,
  `goodsCorner` varchar(255) DEFAULT NULL,
  `goodsDes` varchar(255) DEFAULT NULL,
  `goodsId` varchar(255) DEFAULT NULL,
  `goodsSubDes` varchar(255) DEFAULT NULL,
  `goodsThumbDes` varchar(255) DEFAULT NULL,
  `goodsVendor` varchar(255) DEFAULT NULL,
  `goodsname` varchar(255) DEFAULT NULL,
  `goodstype` varchar(255) DEFAULT NULL,
  `goodstypename` varchar(255) DEFAULT NULL,
  `h` varchar(255) DEFAULT NULL,
  `index_pic` varchar(255) DEFAULT NULL,
  `indexcoordinateid` int(11) DEFAULT NULL,
  `isEmail` varchar(255) DEFAULT NULL,
  `isIdentitycn` varchar(255) DEFAULT NULL,
  `isOrder` varchar(255) DEFAULT NULL,
  `isSellable` varchar(255) DEFAULT NULL,
  `isVideo` varchar(255) DEFAULT NULL,
  `isdeliverydt` varchar(255) DEFAULT NULL,
  `jsonstr` varchar(255) DEFAULT NULL,
  `lables` varchar(255) DEFAULT NULL,
  `orderTitle` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `recommendImagePath` varchar(255) DEFAULT NULL,
  `reviewdate` datetime DEFAULT NULL,
  `reviewdesc` varchar(255) DEFAULT NULL,
  `reviewuser` varchar(255) DEFAULT NULL,
  `s_x` varchar(255) DEFAULT NULL,
  `s_y` varchar(255) DEFAULT NULL,
  `sales` varchar(255) DEFAULT NULL,
  `showlist` int(11) DEFAULT NULL,
  `showname` varchar(255) DEFAULT NULL,
  `showpictype` varchar(255) DEFAULT NULL,
  `showtypeid` bigint(20) DEFAULT NULL,
  `showtypename` varchar(255) DEFAULT NULL,
  `showtypes` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `sort_pic` varchar(255) DEFAULT NULL,
  `sourceimgpath` varchar(255) DEFAULT NULL,
  `sourceimgpath_new` varchar(255) DEFAULT NULL,
  `sourcemess` varchar(255) DEFAULT NULL,
  `speclists` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `str` varchar(255) DEFAULT NULL,
  `supplierguid` int(11) DEFAULT NULL,
  `supplierid` varchar(255) DEFAULT NULL,
  `suppliername` varchar(255) DEFAULT NULL,
  `templateHTML` varchar(255) DEFAULT NULL,
  `thumbImagePath` varchar(255) DEFAULT NULL,
  `updatetime` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `videopath` varchar(255) DEFAULT NULL,
  `videopath_source` varchar(255) DEFAULT NULL,
  `w` varchar(255) DEFAULT NULL,
  `webpicpath` varchar(255) DEFAULT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for haihang_recharge_orders
-- ----------------------------
DROP TABLE IF EXISTS `haihang_recharge_orders`;
CREATE TABLE `haihang_recharge_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL,
  `rcgMobile` varchar(15) DEFAULT NULL,
  `ofrId` varchar(12) DEFAULT NULL,
  `resultStr` text,
  `state` int(11) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for haihang_recharge_record
-- ----------------------------
DROP TABLE IF EXISTS `haihang_recharge_record`;
CREATE TABLE `haihang_recharge_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(32) DEFAULT NULL COMMENT '订单号',
  `state` int(11) DEFAULT NULL COMMENT '充值结果，0-成功，1-失败 2-正在充值中',
  `account` varchar(255) DEFAULT NULL COMMENT 'account充值号码。',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_haihang_recharge_record_orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='海航统一充值平台说明文档--回调结果记录表';

-- ----------------------------
-- Table structure for lmapply_refund_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `lmapply_refund_info_yl`;
CREATE TABLE `lmapply_refund_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '订单号',
  `encryptStr` varchar(32) DEFAULT NULL COMMENT '加密串 MD5(密钥key+unionOrderId）',
  `status` int(11) DEFAULT NULL COMMENT '处理状态 0代表接受，1代表退款已经提交2退款成功3退款失败',
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='退款接口（联盟方开发 ：lmapplyRefund ）\r\n接口描述：\r\n永乐方调用此接口。退款时推送给合作方退款的订单号 (需要联盟方提供接收地址：lmURL)。退款流程请看5.1 接口注意事项：6、退款流程\r\n示例：\r\nhttp://www.xxx.com/lmapplyRefund?unionOrderId=XXX&encryptStr=\r\n接口消息定义：\r\n请求方法：\r\nPOST/ lmURL?unionOrderId=XXX&encryptStr=\r\n请求消息体：\r\n开发接口时在HTTP Header中增加键值对.  Action:接口名\r\n参数名称	是否必选	数据类型	描述\r\nunionOrderId	是	String	联盟订单id\r\nencryptStr	是	String	加密串 MD5(密钥key+unionOrderId）\r\n响应消息：\r\n节点标识	父节点标识	出现次数	数据类型	描述\r\nreturnCode	Response	1		响应码\r\nreturnDesc	Response	1..n		响应码描述\r\n	\r\n响应码	响应码描述\r\n200	成功\r\n109	id不存在\r\n108	联盟方其他错误信息（可自由填写，比如：支付状态不对、更新错误、订单已退款不能重复退款等。）\r\n500	服务异常\r\n';

-- ----------------------------
-- Table structure for order_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `order_info_yl`;
CREATE TABLE `order_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT 'unionOrderId	order	1	String	联盟订单id（必填）',
  `userName` varchar(32) DEFAULT NULL COMMENT '收货人姓名（',
  `phone` varchar(32) DEFAULT NULL COMMENT '收货人手机（必填）',
  `zipCode` varchar(10) DEFAULT NULL COMMENT '收货人邮政编码（非必填）',
  `type` int(11) DEFAULT NULL COMMENT '地址类型（非必填）	1:公司 2:家庭 3:学校',
  `orderAddress` varchar(100) DEFAULT NULL COMMENT '收货地址详情（当dispatchWay为1时，必填）',
  `note` varchar(100) DEFAULT NULL COMMENT '订单备注(非必填)',
  `sendTime` int(11) DEFAULT NULL COMMENT '发票类型（非必填）0.个人、1.单位',
  `lnvoiceType` int(11) DEFAULT NULL COMMENT '发票类型（非必填）0.个人、1.单位',
  `lnvoice` varchar(64) DEFAULT NULL COMMENT '发票抬头（lnvoiceType为0时，默认为“个人”此参数为空；lnvoiceType为1时，填写单位名称，此参数必填）',
  `dispatchWay` int(11) DEFAULT NULL COMMENT '//	dispatchWay	orderInfo	1	Integer	配送方式（必填）1.快递配送；2.上门自取；3.货到付款；4.电子票 暂时只支持 快递配送、上门自取、电子票',
  `productId` int(11) DEFAULT NULL COMMENT '//商品id,下订单时需要根据此productId去查询一遍实时数据',
  `orderID` int(11) DEFAULT NULL COMMENT '永乐onlineOrder_v2返回的id',
  `ifpay` int(11) DEFAULT NULL COMMENT 'ifpay	order	1	Integer	订单是否已支付（必填） 1.未支付、2.已支付 永乐只接受1未支付订单',
  `expressPrice` float DEFAULT NULL COMMENT '快递费（固定快递费时，此参数可为空<联盟也可把固定快递费用填上>，联盟根据自己的规则计算快递费时，此参数非空） 一般使用‘固定快递费’形式。',
  `totalFee` float DEFAULT NULL,
  `ticketTime` varchar(64) DEFAULT NULL COMMENT '演出场次时间（必填）； 永乐XML数据是什么就传什么；',
  `flag` int(11) DEFAULT NULL,
  `ylpayStatus` int(11) DEFAULT NULL COMMENT '调用永乐更新支付接口后，更新该字段，0 为调用更新接口，1调用但失败，2调用成功',
  `extendz` varchar(64) DEFAULT NULL COMMENT '预留',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_order_info_yl_orderNumber` (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='永乐订单';

-- ----------------------------
-- Table structure for orders_info_jxt
-- ----------------------------
DROP TABLE IF EXISTS `orders_info_jxt`;
CREATE TABLE `orders_info_jxt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` varchar(32) DEFAULT NULL,
  `buyername` varchar(64) DEFAULT NULL,
  `tele` varchar(18) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL COMMENT '单价',
  `orderNumber` varchar(32) DEFAULT NULL,
  `id_number` varchar(30) DEFAULT NULL,
  `orders_id` bigint(20) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `errorn` varchar(15) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for portal_pay_callback
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_callback`;
CREATE TABLE `portal_pay_callback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `version` varchar(32) DEFAULT NULL COMMENT '版本号',
  `tranCode` varchar(64) DEFAULT NULL COMMENT '交易代码',
  `merOrderId` varchar(64) DEFAULT NULL COMMENT '商户订单号',
  `merId` varchar(64) DEFAULT NULL COMMENT '商户ID',
  `tranAmt` varchar(64) DEFAULT NULL COMMENT '交易金额',
  `remark` varchar(64) DEFAULT NULL COMMENT '扩展字段',
  `charset` varchar(20) DEFAULT NULL COMMENT '编码方式',
  `signType` varchar(12) DEFAULT NULL COMMENT '签名类型',
  `stateCode` varchar(32) DEFAULT NULL COMMENT '订单状态码\r\n成功：0000\r\n失败：0001',
  `hnapayOrderId` varchar(32) DEFAULT NULL COMMENT '新生支付平台唯一订单号',
  `payType` varchar(32) DEFAULT NULL COMMENT '支付方式',
  `signValue` varchar(1000) DEFAULT NULL COMMENT '签名字符串',
  `payflag` varchar(4) DEFAULT NULL COMMENT '支付标识 0 有网 1 无网',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_callback_merOrderId` (`merOrderId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COMMENT='代扣norify_url回调记录表';

-- ----------------------------
-- Table structure for portal_pay_comment
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_comment`;
CREATE TABLE `portal_pay_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL,
  `q1` varchar(64) DEFAULT NULL,
  `q2` varchar(64) DEFAULT NULL,
  `q3` varchar(64) DEFAULT NULL,
  `payflag` int(11) DEFAULT NULL COMMENT '1:POS机刷卡2:微信支付3:支付宝支付4:新生支付',
  `company` varchar(12) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_comment_orderNumber` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=763 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for portal_pay_ftp_download_file
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_ftp_download_file`;
CREATE TABLE `portal_pay_ftp_download_file` (
  `uuid` varchar(32) NOT NULL,
  `filePath` varchar(150) NOT NULL,
  `savetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `flag` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `index_portal_pay_ftp_download_file_uuid` (`uuid`) USING HASH,
  KEY `index_portal_pay_ftp_download_file_filePath` (`filePath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for portal_pay_ledou
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_ledou`;
CREATE TABLE `portal_pay_ledou` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '  //订单号',
  `outTradeNo` varchar(500) DEFAULT NULL COMMENT '微信订单信息',
  `customeName` varchar(64) DEFAULT NULL,
  `customePhone` varchar(15) DEFAULT NULL,
  `totalPrice` float DEFAULT NULL COMMENT '订单总价',
  `payMoney` float DEFAULT NULL COMMENT '    //订单实付金额',
  `beanCount` int(11) DEFAULT NULL COMMENT '//扣除的乐豆数量',
  `payType` varchar(12) DEFAULT NULL COMMENT '    //支付方式',
  `goodsName` varchar(200) DEFAULT NULL COMMENT '//商品名称',
  `discountAmount` int(11) DEFAULT NULL COMMENT '优惠金额以分为单位',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_portal_pay_ledou_orderNumber` (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=749 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for portal_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_order`;
CREATE TABLE `portal_pay_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(64) DEFAULT NULL COMMENT '订单号',
  `activePartition` varchar(32) DEFAULT NULL,
  `commission` float DEFAULT NULL COMMENT '佣金',
  `count` int(11) DEFAULT NULL COMMENT '订购数量',
  `customerName` varchar(32) DEFAULT NULL COMMENT '订购人姓名',
  `customerCellphone` varchar(32) DEFAULT NULL COMMENT '订购人电话',
  `customerEmail` varchar(32) DEFAULT NULL COMMENT '订购邮箱',
  `purserCellphone` varchar(32) DEFAULT NULL COMMENT '乘务长电话',
  `orderStatus` varchar(32) DEFAULT NULL COMMENT '订单状态',
  `orderFrom` varchar(32) DEFAULT NULL COMMENT '订单来源',
  `orderType` int(11) DEFAULT NULL COMMENT '订单类型(1为商品订单，2为座选升舱订单)',
  `original` varchar(32) DEFAULT NULL,
  `deviceType` varchar(32) DEFAULT NULL COMMENT ' 设备类型：一代设备为g1、二代设备为g2',
  `flightPhase` varchar(32) DEFAULT NULL COMMENT '航段',
  `flyBless` varchar(32) DEFAULT NULL COMMENT '高空祝福',
  `iDNumber` varchar(32) DEFAULT NULL COMMENT '身份证号',
  `indroduction` varchar(32) DEFAULT NULL COMMENT '补充说明',
  `printFlightPhase` varchar(32) DEFAULT NULL,
  `secondaryContact` varchar(32) DEFAULT NULL COMMENT '第二联系人',
  `secondaryPhone` varchar(32) DEFAULT NULL COMMENT '第二联系人电话',
  `secretMonth` varchar(32) DEFAULT NULL COMMENT '神秘盒子配送月份',
  `serialNumber` varchar(32) DEFAULT NULL COMMENT '流水号',
  `totalMoney` float DEFAULT NULL COMMENT '订购总价',
  `customerAddress` varchar(64) DEFAULT NULL,
  `unitPrice` float DEFAULT NULL COMMENT '单价',
  `upload` varchar(32) DEFAULT NULL,
  `date` varchar(32) DEFAULT NULL,
  `flightNumber` varchar(32) DEFAULT NULL,
  `originPlace` varchar(32) DEFAULT NULL,
  `destination` varchar(32) DEFAULT NULL,
  `purserName` varchar(32) DEFAULT NULL,
  `cellphone` varchar(32) DEFAULT NULL,
  `purserEmail` varchar(32) DEFAULT NULL,
  `payType` varchar(32) DEFAULT NULL,
  `newSeat` varchar(12) DEFAULT NULL,
  `oldSeat` varchar(12) DEFAULT NULL,
  `payflag` varchar(10) DEFAULT NULL COMMENT '0有网1无网',
  `cabin` varchar(12) DEFAULT NULL,
  `moneyType` varchar(12) DEFAULT NULL,
  `passengerName` varchar(32) DEFAULT NULL,
  `passengerPhone` varchar(15) DEFAULT NULL,
  `passengerTicketName` varchar(90) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `uniqueCode` varchar(64) DEFAULT NULL,
  `invoiceTitle` varchar(100) DEFAULT NULL,
  `invoiceName` varchar(100) DEFAULT NULL,
  `invoiceCell` varchar(100) DEFAULT NULL,
  `invoiceAddress` varchar(200) DEFAULT NULL,
  `payStatus` varchar(4) DEFAULT NULL COMMENT '支付结果0接收，1处理中，2支付成功3支付失败',
  `supplierguid` varchar(12) DEFAULT NULL COMMENT '供应商id',
  `logisticsId` varchar(32) DEFAULT NULL COMMENT '物流单号',
  `company` varchar(12) DEFAULT NULL,
  `refundAmount` int(11) DEFAULT NULL COMMENT '退款金额单位分',
  `discountAmount` int(11) DEFAULT NULL COMMENT '优惠金额单位分',
  `undiscountableAmount` int(11) DEFAULT NULL COMMENT '优惠前价格单位分',
  `idCard` varchar(26) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_order_orderNumber` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=903 DEFAULT CHARSET=utf8mb4 COMMENT='代扣订单信息表';

-- ----------------------------
-- Table structure for portal_pay_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_order_goods`;
CREATE TABLE `portal_pay_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(64) DEFAULT NULL,
  `goodsId` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `goodsName` varchar(64) DEFAULT NULL,
  `goodsSize` varchar(32) DEFAULT NULL COMMENT '商品规格',
  `goodsCount` int(11) DEFAULT NULL COMMENT '订购数量',
  `goodsMoney` float DEFAULT NULL COMMENT '单个商品总价格',
  `status` varchar(10) DEFAULT NULL,
  `supplierguid` varchar(12) DEFAULT NULL COMMENT '供应商id',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_order_goods_orderNumber` (`orderNumber`) USING BTREE,
  KEY `portal_pay_order_goods_goodsId` (`goodsId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=utf8mb4 COMMENT='代扣订单商品信息表';

-- ----------------------------
-- Table structure for portal_pay_query
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_query`;
CREATE TABLE `portal_pay_query` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serialID` varchar(32) NOT NULL,
  `mode` varchar(2) DEFAULT NULL,
  `type` varchar(2) DEFAULT NULL,
  `resultCode` varchar(12) DEFAULT NULL,
  `queryDetailsSize` varchar(2) DEFAULT NULL,
  `queryDetails` varchar(120) DEFAULT NULL,
  `partnerID` varchar(12) DEFAULT NULL,
  `remark` varchar(2) DEFAULT NULL,
  `charset` varchar(2) DEFAULT NULL,
  `signType` varchar(1) DEFAULT NULL,
  `flag` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_query_serialID` (`serialID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=899 DEFAULT CHARSET=utf8mb4 COMMENT='代扣查询接口反馈结果';

-- ----------------------------
-- Table structure for portal_pay_refund_callback
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_refund_callback`;
CREATE TABLE `portal_pay_refund_callback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `refundOrderID` varchar(32) DEFAULT NULL COMMENT '商户退款订单',
  `resultCode` varchar(32) DEFAULT NULL COMMENT '处理结果码',
  `stateCode` varchar(32) DEFAULT NULL COMMENT '退款交易状态码1：退款处理中2：退款成功3：退款失败',
  `orderID` varchar(32) DEFAULT NULL COMMENT '商户原始订单',
  `refundAmount` float DEFAULT NULL COMMENT '商户退款金额',
  `refundTime` varchar(14) DEFAULT NULL COMMENT '商户退款订单时间',
  `completeTime` varchar(14) DEFAULT NULL COMMENT '处理完成时间',
  `refundNo` varchar(32) DEFAULT NULL COMMENT '退款流水号',
  `partnerID` varchar(32) DEFAULT NULL COMMENT 'partnerID',
  `remark` varchar(32) DEFAULT NULL,
  `payflag` varchar(4) DEFAULT NULL COMMENT '有网 无网模式',
  `status` varchar(4) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_portal_pay_refund_callback_` (`orderID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for portal_pay_synchro
-- ----------------------------
DROP TABLE IF EXISTS `portal_pay_synchro`;
CREATE TABLE `portal_pay_synchro` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `version` varchar(32) DEFAULT NULL COMMENT '版本号',
  `tranCode` varchar(64) DEFAULT NULL COMMENT '交易代码',
  `merOrderId` varchar(64) DEFAULT NULL COMMENT '商户订单号',
  `merId` varchar(64) DEFAULT NULL COMMENT '商户ID',
  `tranAmt` varchar(64) DEFAULT NULL COMMENT '交易金额',
  `remark` varchar(64) DEFAULT NULL COMMENT '扩展字段',
  `charset` varchar(20) DEFAULT NULL COMMENT '编码方式',
  `signType` varchar(12) DEFAULT NULL COMMENT '签名类型',
  `resultCode` varchar(32) DEFAULT NULL COMMENT '订单状态码\r\n成功：0000\r\n失败：0001',
  `errorCode` varchar(32) DEFAULT NULL,
  `hnapayOrderId` varchar(32) DEFAULT NULL COMMENT '新生支付平台唯一订单号',
  `payType` varchar(32) DEFAULT NULL COMMENT '支付方式',
  `signValue` varchar(1000) DEFAULT NULL COMMENT '签名字符串',
  `payflag` varchar(4) DEFAULT NULL COMMENT '支付标识 0 有网 1 无网',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pay_synchro_merOrderId` (`merOrderId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8mb4 COMMENT='代扣同步反馈结果表';

-- ----------------------------
-- Table structure for prepaid_cards
-- ----------------------------
DROP TABLE IF EXISTS `prepaid_cards`;
CREATE TABLE `prepaid_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `makeCardNum` varchar(32) DEFAULT NULL COMMENT '制卡批次号',
  `price` float unsigned zerofill DEFAULT NULL COMMENT '卡面值',
  `cardNum` varchar(32) DEFAULT NULL COMMENT '卡号',
  `cardPass` varchar(32) DEFAULT NULL COMMENT '密码',
  `flag` int(11) DEFAULT NULL COMMENT '0初始化状态，1已经出售，2已支付，无库存',
  `extendz` varchar(64) DEFAULT NULL,
  `messStatus` int(11) DEFAULT NULL COMMENT '短信是否发送1已发送2未发送',
  `emailStatus` int(11) DEFAULT NULL COMMENT '邮件是否发送1已发送2未发送',
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '订单号',
  `memo` varchar(32) DEFAULT NULL COMMENT '备注',
  `validtime` datetime DEFAULT NULL COMMENT '有效日期',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8mb4 COMMENT='预付费卡  储值卡';

-- ----------------------------
-- Table structure for product_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `product_info_yl`;
CREATE TABLE `product_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL COMMENT '商品id',
  `status` int(11) DEFAULT NULL COMMENT '商品状态（0热卖；1预售；2无效；3待定；4售完；5延期；6取消） 联盟可卖状态为0热卖、1预售的票品',
  `playName` varchar(100) DEFAULT NULL COMMENT '票品名称',
  `nameSynonym` varchar(100) DEFAULT NULL COMMENT '票品同义词',
  `onlineseat` int(11) DEFAULT NULL COMMENT 'onlineseat	product	1	Integer	票品是否支持在线选座  0:不支持1:支持',
  `shelfStatus` int(11) DEFAULT NULL COMMENT '商品上下架 （1 上架 0 下架）',
  `trueBuy` int(11) DEFAULT NULL COMMENT '是否支持实名制：0.不支持、1.支持',
  `fconfigId` int(11) DEFAULT NULL COMMENT '	票品所属分站ID',
  `playCityId` int(11) DEFAULT NULL COMMENT '票品城市ID',
  `playCityCode` varchar(20) DEFAULT NULL COMMENT '票品城市编码',
  `playCity` varchar(20) DEFAULT NULL COMMENT '城市名称',
  `playAddressId` int(11) DEFAULT NULL COMMENT '场馆ID唯一标识',
  `playAddress` varchar(50) DEFAULT NULL COMMENT '场馆名称',
  `playTypeAId` int(11) DEFAULT NULL COMMENT '票品大类别ID',
  `playTypeBId` int(11) DEFAULT NULL COMMENT '	票品子类别ID',
  `playTypeA` varchar(30) DEFAULT NULL COMMENT '票品大类别名称',
  `playTypeB` varchar(30) DEFAULT NULL COMMENT '票品子类别名称',
  `productPicture` varchar(100) DEFAULT NULL COMMENT '票品图片(尺寸：288 * 384px)',
  `productPictureSmall` varchar(100) DEFAULT NULL COMMENT '	票品缩略图片(尺寸：90 * 120px)',
  `productPictureLocal` varchar(255) DEFAULT NULL COMMENT '本地图片路径',
  `seatPicture` varchar(100) DEFAULT NULL COMMENT '票区图',
  `productStartTime` varchar(20) DEFAULT NULL COMMENT '票品开始时间',
  `productEndTime` varchar(20) DEFAULT NULL COMMENT '票品结束时间',
  `Sharedescribe` text CHARACTER SET utf16le COMMENT '票品缩略简介',
  `ProductProfile` text COMMENT '票品简介(html代码)',
  `venueIntroduction` text COMMENT '场馆简介',
  `venueMap` varchar(200) DEFAULT NULL COMMENT '场馆乘车路线',
  `venueStall` varchar(100) DEFAULT NULL COMMENT '场馆位置',
  `flag` int(11) DEFAULT '0',
  `extendz` varchar(600) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_productId_product_info_yl` (`productId`),
  KEY `index_playCityCode_product_info_yl` (`playCityCode`),
  KEY `index_flag_product_info_yl` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=80572 DEFAULT CHARSET=utf8mb4 COMMENT='永乐商品信息';

-- ----------------------------
-- Table structure for refund_record_wx
-- ----------------------------
DROP TABLE IF EXISTS `refund_record_wx`;
CREATE TABLE `refund_record_wx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `return_code` varchar(32) DEFAULT NULL,
  `return_msg` varchar(32) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `mch_id` varchar(12) DEFAULT NULL,
  `nonce_str` varchar(32) DEFAULT NULL,
  `sign` varchar(32) DEFAULT NULL,
  `result_code` varchar(32) DEFAULT NULL,
  `transaction_id` varchar(32) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `out_refund_no` varchar(64) DEFAULT NULL,
  `refund_id` varchar(32) DEFAULT NULL,
  `refund_channel` varchar(32) DEFAULT NULL,
  `refund_fee` int(11) DEFAULT NULL,
  `coupon_refund_fee` int(11) DEFAULT NULL,
  `total_fee` int(11) DEFAULT NULL,
  `cash_fee` int(11) DEFAULT NULL,
  `coupon_refund_count` int(11) DEFAULT NULL,
  `cash_refund_fee` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `err_code` varchar(12) DEFAULT NULL,
  `err_code_des` varchar(64) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for refund_record_zfb
-- ----------------------------
DROP TABLE IF EXISTS `refund_record_zfb`;
CREATE TABLE `refund_record_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` varchar(32) DEFAULT NULL,
  `code` varchar(12) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `open_id` varchar(64) DEFAULT NULL,
  `refund_fee` varchar(14) DEFAULT NULL,
  `gmt_refund_pay` varchar(20) DEFAULT NULL,
  `send_back_fee` varchar(20) DEFAULT NULL,
  `trade_no` varchar(32) DEFAULT NULL COMMENT '2017060221001004900298439804',
  `buyer_logon_id` varchar(12) DEFAULT NULL COMMENT '185****7139',
  `buyer_user_id` varchar(32) DEFAULT NULL,
  `fund_change` varchar(12) DEFAULT NULL,
  `company` varchar(20) DEFAULT 'xilehang',
  `messageType` int(11) DEFAULT NULL COMMENT '1无短信2有短信',
  `bussinessType` int(11) DEFAULT NULL COMMENT ' 业务类型1商城2座选升舱',
  `refund_reason` varchar(32) DEFAULT NULL,
  `memo` varchar(64) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_data_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_dictionary`;
CREATE TABLE `sys_data_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyz` varchar(100) NOT NULL COMMENT '关键字',
  `valuez` varchar(150) DEFAULT NULL COMMENT '多个值之间用英文,隔开',
  `descz` varchar(500) DEFAULT NULL,
  `indexz` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sys_data_dictionary_keyz_unique` (`keyz`,`indexz`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_err_mess
-- ----------------------------
DROP TABLE IF EXISTS `sys_err_mess`;
CREATE TABLE `sys_err_mess` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project` smallint(4) DEFAULT NULL,
  `method` text,
  `errMess` text,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_execute_sh
-- ----------------------------
DROP TABLE IF EXISTS `sys_execute_sh`;
CREATE TABLE `sys_execute_sh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(200) DEFAULT NULL,
  `detail` varchar(200) DEFAULT NULL,
  `flag` int(4) DEFAULT NULL,
  `firstruntime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operate_log`;
CREATE TABLE `sys_operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(32) DEFAULT NULL,
  `loginIp` varchar(20) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `url` varchar(65) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43112 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `sys_organization`;
CREATE TABLE `sys_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `code` varchar(64) NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `seq` int(1) NOT NULL DEFAULT '0',
  `isdefault` int(1) DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `seq` int(4) NOT NULL DEFAULT '0',
  `state` int(4) NOT NULL DEFAULT '0',
  `resourcetype` int(4) NOT NULL DEFAULT '0',
  `isdefault` int(4) DEFAULT NULL COMMENT '//1非默认资源可以删除，0默认资源不可以删除',
  `hasChild` int(4) DEFAULT NULL COMMENT '默认0没有，1有',
  `createdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=451 DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `seq` int(1) NOT NULL DEFAULT '0',
  `description` varchar(64) DEFAULT NULL,
  `isdefault` int(1) NOT NULL DEFAULT '0',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  `create_time` varchar(255) DEFAULT NULL,
  `update_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource` (
  `role_id` int(5) NOT NULL,
  `resource_id` int(5) NOT NULL,
  PRIMARY KEY (`role_id`,`resource_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色资源';

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `sex` int(1) DEFAULT '0',
  `age` int(1) DEFAULT '0',
  `usertype` int(1) DEFAULT '0',
  `isdefault` int(1) DEFAULT '0',
  `state` int(1) DEFAULT '0',
  `organization_id` int(11) DEFAULT '0',
  `organizationName` varchar(32) DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `airCompany` varchar(10) DEFAULT NULL COMMENT '航渠HU  Y8 ',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginname` (`loginname`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(5) NOT NULL,
  `role_id` int(5) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Table structure for term_info
-- ----------------------------
DROP TABLE IF EXISTS `term_info`;
CREATE TABLE `term_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `serial` varchar(32) DEFAULT NULL COMMENT '序列号',
  `termId` varchar(12) DEFAULT NULL COMMENT '设备编号',
  `mac` varchar(32) DEFAULT NULL COMMENT 'mac地址',
  `mposId` varchar(32) DEFAULT NULL COMMENT 'mpos编号',
  `sendtimeStr` varchar(32) DEFAULT NULL COMMENT '派发日期',
  `onetimeSendnum` varchar(4) DEFAULT NULL COMMENT '一批派发数量',
  `cityName` varchar(32) DEFAULT NULL COMMENT '基地名称',
  `apkVersionName` varchar(32) DEFAULT NULL COMMENT '程序版本',
  `airVersionName` varchar(12) DEFAULT NULL COMMENT '航渠版本',
  `mposVersion` varchar(32) DEFAULT NULL COMMENT 'mpos版本',
  `sendReason` varchar(100) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `term_info_mac_airVersionName` (`airVersionName`,`mac`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tickettime_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `tickettime_info_yl`;
CREATE TABLE `tickettime_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL,
  `ticketTime` varchar(20) DEFAULT NULL COMMENT '演出场次日期(快递票品演出前三天下架，上门自取票品演出前一天下架',
  `flag` int(11) DEFAULT '0',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_productId_tickettime_info_yl` (`productId`),
  KEY `index_flag_tickettime_info_yl` (`flag`),
  KEY `index_id_tickettime_info_yl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170282 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tickset_info_yl
-- ----------------------------
DROP TABLE IF EXISTS `tickset_info_yl`;
CREATE TABLE `tickset_info_yl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL,
  `ticketTimeInfoId` int(11) DEFAULT NULL,
  `productPlayid` int(11) DEFAULT NULL COMMENT '	票价ID',
  `price` float DEFAULT NULL,
  `priceInfo` varchar(100) DEFAULT NULL COMMENT '票价价格说明',
  `priceStarus` int(11) DEFAULT NULL COMMENT '商品票价状态(1.可售；2.售完；3.隐藏；4.预订；5.无效；)联盟展示及可卖状态为：1.可售、4.预订；其他状态不展示；',
  `priceType` int(11) DEFAULT NULL COMMENT '票品票价类型1.正常票、2.套票、3.特殊票',
  `priceNum` int(11) DEFAULT NULL COMMENT '票品票价数量 -1 时为不限制数量',
  `flag` int(11) DEFAULT '0',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_productId_tickset_info_yl` (`productId`),
  KEY `index_ticketTimeInfoId_tickset_info_yl` (`ticketTimeInfoId`),
  KEY `index_flag_tickset_info_yl` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=32261 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_callback_success_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_callback_success_zfb`;
CREATE TABLE `trade_callback_success_zfb` (
  `id` char(32) NOT NULL,
  `open_id` char(32) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `buyer_logon_id` char(11) DEFAULT NULL,
  `auth_app_id` char(16) DEFAULT NULL,
  `out_trade_no` varchar(64) DEFAULT NULL,
  `point_amount` float DEFAULT NULL,
  `total_amount` float DEFAULT NULL,
  `buyer_id` char(16) DEFAULT NULL,
  `trade_no` varchar(32) DEFAULT NULL,
  `notify_time` varchar(32) DEFAULT NULL,
  `invoice_amount` float DEFAULT NULL,
  `trade_status` varchar(32) DEFAULT NULL,
  `gmt_payment` varchar(32) DEFAULT NULL,
  `gmt_create` varchar(32) DEFAULT NULL,
  `buyer_pay_amount` float DEFAULT NULL,
  `receipt_amount` float DEFAULT NULL,
  `seller_id` char(16) DEFAULT NULL,
  `app_id` char(16) DEFAULT NULL,
  `seller_email` varchar(64) DEFAULT NULL,
  `notify_id` varchar(300) DEFAULT NULL,
  `gmt_refund` varchar(32) DEFAULT NULL,
  `gmt_close` varchar(32) DEFAULT NULL,
  `business_scene` varchar(12) DEFAULT NULL,
  `out_channel_inst` varchar(64) DEFAULT NULL,
  `refund_status` varchar(32) DEFAULT NULL,
  `notify_type` varchar(32) DEFAULT NULL,
  `sign_type` varchar(12) DEFAULT NULL,
  `total_fee` float DEFAULT NULL,
  `extra_common_param` varchar(200) DEFAULT NULL,
  `payment_type` varchar(4) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `payflag` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tradepaycallbacksuccess_out_trade_no` (`out_trade_no`) USING BTREE,
  KEY `tradepaycallbacksuccess_trade_no` (`trade_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付宝回调成功信息记录表';

-- ----------------------------
-- Table structure for trade_callback_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_callback_zfb`;
CREATE TABLE `trade_callback_zfb` (
  `id` char(32) NOT NULL,
  `open_id` char(32) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `extra_common_param` varchar(200) DEFAULT NULL,
  `payment_type` varchar(4) DEFAULT NULL,
  `buyer_logon_id` char(11) DEFAULT NULL,
  `auth_app_id` char(16) DEFAULT NULL,
  `out_trade_no` varchar(64) DEFAULT NULL,
  `point_amount` float DEFAULT NULL,
  `total_amount` float DEFAULT NULL,
  `total_fee` float DEFAULT NULL,
  `buyer_id` char(16) DEFAULT NULL,
  `trade_no` varchar(32) DEFAULT NULL,
  `notify_type` varchar(32) DEFAULT NULL,
  `sign_type` varchar(12) DEFAULT NULL,
  `notify_time` varchar(32) DEFAULT NULL,
  `invoice_amount` float DEFAULT NULL,
  `refund_status` varchar(32) DEFAULT NULL,
  `trade_status` varchar(32) DEFAULT NULL,
  `gmt_refund` varchar(32) DEFAULT NULL,
  `gmt_close` varchar(32) DEFAULT NULL,
  `gmt_payment` varchar(32) DEFAULT NULL,
  `gmt_create` varchar(32) DEFAULT NULL,
  `buyer_pay_amount` float DEFAULT NULL,
  `receipt_amount` float DEFAULT NULL,
  `business_scene` varchar(12) DEFAULT NULL,
  `out_channel_inst` varchar(64) DEFAULT NULL,
  `seller_id` char(16) DEFAULT NULL,
  `app_id` char(16) DEFAULT NULL,
  `seller_email` varchar(64) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `notify_id` varchar(300) DEFAULT NULL,
  `payflag` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tradepaycallbacksuccess_out_trade_no` (`out_trade_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付宝回调信息记录表';

-- ----------------------------
-- Table structure for trade_confirm_order
-- ----------------------------
DROP TABLE IF EXISTS `trade_confirm_order`;
CREATE TABLE `trade_confirm_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '订单号',
  `idCard` varchar(32) DEFAULT NULL COMMENT '身份证或护照号',
  `address` varchar(100) DEFAULT NULL COMMENT '有效通讯地址',
  `passengerInfo` varchar(100) DEFAULT NULL COMMENT '其它联系方式',
  `imgPath` varchar(150) DEFAULT NULL COMMENT '订单状态',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2124 DEFAULT CHARSET=utf8mb4 COMMENT='认购单 orderNumber为订单号';

-- ----------------------------
-- Table structure for trade_error_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_error_zfb`;
CREATE TABLE `trade_error_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner` varchar(20) DEFAULT NULL COMMENT '合作者身份id',
  `out_trade_no` varchar(64) DEFAULT NULL COMMENT '商户网站唯一订单号',
  `error_code` varchar(128) DEFAULT NULL,
  `return_url` varchar(100) DEFAULT NULL,
  `buyer_email` varchar(32) DEFAULT NULL,
  `buyer_id` varchar(20) DEFAULT NULL,
  `seller_id` varchar(20) DEFAULT NULL,
  `payflag` varchar(4) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alipay_unmessage_synchro_out_trade_no` (`out_trade_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='请求出错时通知参数列表';

-- ----------------------------
-- Table structure for trade_feedback_boc
-- ----------------------------
DROP TABLE IF EXISTS `trade_feedback_boc`;
CREATE TABLE `trade_feedback_boc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sResponseCode` varchar(32) DEFAULT NULL,
  `sResponseDesc` varchar(100) DEFAULT NULL,
  `sSysUniqueID` varchar(32) DEFAULT NULL,
  `sCardNOMask` varchar(20) DEFAULT NULL,
  `sMerchantID` varchar(20) DEFAULT NULL,
  `sTerminalID` varchar(12) DEFAULT NULL,
  `sMerchantNameCH` varchar(64) DEFAULT NULL,
  `sCardType` varchar(64) DEFAULT NULL,
  `sTransType` varchar(32) DEFAULT NULL,
  `sBatchNO` varchar(12) DEFAULT NULL,
  `sTraceNO` varchar(12) DEFAULT NULL,
  `sInvoiceNO` varchar(12) DEFAULT NULL,
  `sAuthCode` varchar(12) DEFAULT NULL,
  `sTransDate` varchar(12) DEFAULT NULL,
  `sTransTime` varchar(12) DEFAULT NULL,
  `sAmountLoc` varchar(15) DEFAULT NULL,
  `sEntryMode` varchar(12) DEFAULT NULL,
  `sEntryModeChar` varchar(64) DEFAULT NULL,
  `sRefNO` varchar(20) DEFAULT NULL,
  `sRemark` varchar(500) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `sOrderNo` varchar(64) DEFAULT NULL,
  `sCardholderName` varchar(32) DEFAULT NULL,
  `matc` int(11) DEFAULT '0',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_trade_feedback_boc_sOrderNo` (`sOrderNo`)
) ENGINE=InnoDB AUTO_INCREMENT=11780 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_goods
-- ----------------------------
DROP TABLE IF EXISTS `trade_goods`;
CREATE TABLE `trade_goods` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(96) DEFAULT NULL,
  `goodsId` varchar(64) DEFAULT NULL,
  `goodsName` varchar(100) DEFAULT NULL,
  `price` float(10,0) DEFAULT NULL,
  `quantity` varchar(11) DEFAULT NULL,
  `goodsSize` varchar(100) DEFAULT NULL,
  `discountAmount` float DEFAULT NULL COMMENT '优惠金额',
  `supplierguid` varchar(20) DEFAULT NULL,
  `memo` varchar(300) DEFAULT NULL,
  `isDelete` int(11) DEFAULT '0' COMMENT '是否删除0null为默认1是删除',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tradeGoods_orderNumber` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7048 DEFAULT CHARSET=utf8mb4 COMMENT='所有商品';

-- ----------------------------
-- Table structure for trade_goods_kl
-- ----------------------------
DROP TABLE IF EXISTS `trade_goods_kl`;
CREATE TABLE `trade_goods_kl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL,
  `buyAmount` int(11) DEFAULT NULL,
  `payAmount` double DEFAULT NULL,
  `taxPayAmount` double DEFAULT NULL,
  `channelSalePrice` double DEFAULT NULL,
  `logisticsPayAmount` double DEFAULT NULL,
  `importType` int(11) DEFAULT NULL,
  `needVerifyLevel` int(11) DEFAULT NULL,
  `warehouseId` int(11) DEFAULT NULL,
  `goodsId` varchar(12) DEFAULT NULL,
  `skuId` varchar(64) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=390 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_goods_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_goods_zfb`;
CREATE TABLE `trade_goods_zfb` (
  `id` char(32) NOT NULL,
  `outTradeNo` varchar(96) DEFAULT NULL,
  `goodsId` varchar(64) DEFAULT NULL,
  `goodsName` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `quantity` varchar(11) DEFAULT NULL,
  `goodsSize` varchar(100) DEFAULT NULL,
  `discountAmount` float DEFAULT NULL COMMENT '优惠金额',
  `supplierguid` varchar(12) DEFAULT NULL COMMENT '供应商id',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tradeGoodsZfb_out_trade_no` (`outTradeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调用支付宝生成二维码，所需订单商品信息';

-- ----------------------------
-- Table structure for trade_integral_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_integral_zfb`;
CREATE TABLE `trade_integral_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionid` varchar(32) DEFAULT NULL COMMENT 'sessionid',
  `amount` float DEFAULT NULL COMMENT '金额',
  `oid` varchar(32) DEFAULT NULL COMMENT '订单号',
  `remark` varchar(12) DEFAULT NULL COMMENT '0初始化，1订单支付成功',
  `sign` varchar(32) DEFAULT NULL COMMENT 'md5签名',
  `savetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_trade_integral_zfb_oid` (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb4 COMMENT='机上portal 购物送积分项目需求如下：\r\n机上用户下单会增加 sessionid 参数，标示用户使用。 在确认此用户下单付费成功后请发送通知。\r\n通知示例：{"sessionid":"123456","amount":"总金额","oid":"订单编号","sign":"签名"}\r\nsign:   sessionid+oid+"shareco"  的md5值。';

-- ----------------------------
-- Table structure for trade_logistics
-- ----------------------------
DROP TABLE IF EXISTS `trade_logistics`;
CREATE TABLE `trade_logistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '商品订单号',
  `goodsId` int(11) DEFAULT NULL COMMENT '规格id',
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `logisticsId` varchar(32) DEFAULT NULL COMMENT '物流单号',
  `logisticsCompany` varchar(64) DEFAULT NULL COMMENT '物流公司',
  `logisticsType` varchar(4) DEFAULT NULL COMMENT '物流状态0未发货1已发货2已收货',
  `memo` varchar(128) DEFAULT NULL COMMENT '备注',
  `sendtime` varchar(18) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_orderNumber_trade_logistics` (`orderNumber`) USING BTREE,
  KEY `index_logisticsId_trade_logistics` (`logisticsId`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COMMENT='物流信息';

-- ----------------------------
-- Table structure for trade_notify_handle_errmess
-- ----------------------------
DROP TABLE IF EXISTS `trade_notify_handle_errmess`;
CREATE TABLE `trade_notify_handle_errmess` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(36) DEFAULT NULL,
  `tellPhone` varchar(11) DEFAULT NULL,
  `userName` varchar(30) DEFAULT NULL,
  `errMessage` text,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_notify_result
-- ----------------------------
DROP TABLE IF EXISTS `trade_notify_result`;
CREATE TABLE `trade_notify_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(36) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL COMMENT '供应商id',
  `orderSendStatus` int(11) DEFAULT NULL COMMENT '订单发送结果 1发送成功2发送失败',
  `orderSendSavetime` datetime DEFAULT NULL,
  `orderSendUpdatetime` datetime DEFAULT NULL,
  `orderSendSendtimes` int(11) DEFAULT NULL,
  `paySuccessSendStatus` int(11) DEFAULT NULL COMMENT '支付成功结果通知',
  `paySuccessSavetime` datetime DEFAULT NULL,
  `paySuccessUpdatetime` datetime DEFAULT NULL,
  `paySuccessSendtimes` int(11) DEFAULT NULL,
  `payFailSendStatus` int(11) DEFAULT NULL COMMENT '支付失败结果通知',
  `payFailSendSavetime` datetime DEFAULT NULL,
  `payFailSendUpdatetime` datetime DEFAULT NULL,
  `payFailSendSendtimes` int(11) DEFAULT NULL,
  `payRefundSendStatus` int(11) DEFAULT NULL COMMENT '退款通知',
  `payRefundSavetime` datetime DEFAULT NULL,
  `payRefundUpdatetime` datetime DEFAULT NULL,
  `payRefundSendTimes` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1601 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务通知订单，通知支付结果，退款结果';

-- ----------------------------
-- Table structure for trade_notify_supplier_url
-- ----------------------------
DROP TABLE IF EXISTS `trade_notify_supplier_url`;
CREATE TABLE `trade_notify_supplier_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierguid` int(11) DEFAULT NULL COMMENT '供应商id',
  `url` varchar(200) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trade_notify_supplier_url_unique` (`supplierguid`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_orders
-- ----------------------------
DROP TABLE IF EXISTS `trade_orders`;
CREATE TABLE `trade_orders` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '订单号',
  `buyerName` varchar(32) DEFAULT NULL COMMENT '订购人姓名',
  `buyerTelephone` varchar(32) DEFAULT NULL COMMENT '订购人电话',
  `buyerEmail` varchar(64) DEFAULT NULL COMMENT '订购邮箱',
  `address` varchar(64) DEFAULT NULL COMMENT '订购地址',
  `memo` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `idCard` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `device` varchar(32) DEFAULT NULL COMMENT '设备',
  `paytype` varchar(16) DEFAULT NULL COMMENT '支付方式',
  `activePartition` varchar(32) DEFAULT NULL COMMENT '活动分区',
  `orderFrom` varchar(12) DEFAULT NULL COMMENT '订单来源',
  `mbdMonth` varchar(12) DEFAULT NULL COMMENT '神秘盒子配送月份',
  `totalAmount` double DEFAULT NULL COMMENT '商品总价',
  `totalAmountStr` varchar(16) DEFAULT NULL,
  `ordertime` varchar(32) DEFAULT NULL COMMENT '下单时间',
  `consigneeName` varchar(32) DEFAULT NULL COMMENT '收获人姓名',
  `consigneeTelephone` varchar(32) DEFAULT NULL COMMENT '收货人电话',
  `blessing` varchar(32) DEFAULT NULL COMMENT '祝福语',
  `status` varchar(4) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `flightNumber` varchar(20) DEFAULT NULL COMMENT '航班号',
  `flightPhase` varchar(20) DEFAULT NULL COMMENT '航段',
  `company` varchar(12) DEFAULT 'xilehang' COMMENT '公司除了我司，新生还有圣地亚',
  `payStatus` int(11) DEFAULT '0' COMMENT '支付状态0初始化1支付成功2支付失败3已经退款',
  `refundAmount` int(11) DEFAULT NULL COMMENT '退款金额单位分',
  `discountAmount` int(11) DEFAULT '0' COMMENT '优惠金额单位分',
  `undiscountableAmount` int(11) DEFAULT '0' COMMENT '优惠前价格单位分',
  `cartVersion` varchar(300) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trade_orders_orderNumber_unique` (`orderNumber`) USING BTREE,
  KEY `index_trade_orders_orderNumber` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6740 DEFAULT CHARSET=utf8 COMMENT='调用支付宝生成二维码，所需订单信息   还有其他支付包订单信息';

-- ----------------------------
-- Table structure for trade_orders_cart_boc
-- ----------------------------
DROP TABLE IF EXISTS `trade_orders_cart_boc`;
CREATE TABLE `trade_orders_cart_boc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `IDNumber` varchar(32) DEFAULT NULL,
  `activePartition` varchar(32) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `customerAddress` varchar(32) DEFAULT NULL,
  `customerCellphone` varchar(15) DEFAULT NULL,
  `customerEmail` varchar(32) DEFAULT NULL,
  `customerName` varchar(32) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `destination` varchar(20) DEFAULT NULL,
  `deviceType` varchar(12) DEFAULT NULL,
  `flightNumber` varchar(20) DEFAULT NULL,
  `flightPhase` varchar(20) DEFAULT NULL,
  `flyBless` varchar(20) DEFAULT NULL,
  `indroduction` varchar(32) DEFAULT NULL,
  `orderFrom` varchar(12) DEFAULT NULL,
  `orderNumber` varchar(32) DEFAULT NULL,
  `orderStatus` varchar(32) DEFAULT NULL,
  `orderType` int(11) DEFAULT NULL,
  `original` varchar(20) DEFAULT NULL,
  `payType` varchar(12) DEFAULT NULL,
  `purserCellphone` varchar(15) DEFAULT NULL,
  `purserName` varchar(32) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL COMMENT '分',
  `cardNOMask` varchar(24) DEFAULT NULL,
  `expDate` varchar(12) DEFAULT NULL,
  `offTransDate` varchar(12) DEFAULT NULL,
  `offTransTime` varchar(12) DEFAULT NULL,
  `terminalID` varchar(12) DEFAULT NULL,
  `responseCode` varchar(12) DEFAULT NULL,
  `responseDesc` varchar(32) DEFAULT NULL,
  `secondaryContact` varchar(12) DEFAULT NULL,
  `secondaryPhone` varchar(15) DEFAULT NULL,
  `serialNumber` varchar(32) DEFAULT NULL,
  `sysUniqueID` varchar(32) DEFAULT NULL,
  `totalMoney` double DEFAULT NULL,
  `totalAmount` double DEFAULT NULL,
  `discountAmount` double DEFAULT NULL,
  `payStatus` int(11) DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `otherPhone` varchar(20) DEFAULT NULL,
  `uniqueCode` varchar(64) DEFAULT NULL,
  `company` varchar(12) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_trade_orders_cart_boc_orderNumber` (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_orders_kl
-- ----------------------------
DROP TABLE IF EXISTS `trade_orders_kl`;
CREATE TABLE `trade_orders_kl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL,
  `districtName` varchar(32) DEFAULT NULL,
  `accountId` varchar(32) DEFAULT NULL,
  `identityId` varchar(32) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `cityName` varchar(21) DEFAULT NULL,
  `provinceName` varchar(21) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `identityPicFront` varchar(100) DEFAULT NULL,
  `identityPicBack` varchar(100) DEFAULT NULL,
  `orderAmount` double DEFAULT NULL,
  `payAmount` double DEFAULT NULL,
  `taxPayAmount` double DEFAULT NULL,
  `logisticsPayAmount` double DEFAULT NULL,
  `logisticsTaxAmount` double DEFAULT NULL,
  `needVerifyLevel` int(11) DEFAULT NULL,
  `payStatus` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_orders_seat_boc
-- ----------------------------
DROP TABLE IF EXISTS `trade_orders_seat_boc`;
CREATE TABLE `trade_orders_seat_boc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabin` varchar(12) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `destination` varchar(20) DEFAULT NULL,
  `evidenceNo` varchar(12) DEFAULT NULL,
  `flightNumber` varchar(20) DEFAULT NULL,
  `flightPhase` varchar(20) DEFAULT NULL,
  `invoiceAddress` varchar(150) DEFAULT NULL,
  `invoiceCell` varchar(16) DEFAULT NULL,
  `invoiceName` varchar(60) DEFAULT NULL,
  `invoiceTitle` varchar(60) DEFAULT NULL,
  `moneyType` varchar(12) DEFAULT NULL,
  `newSeat` varchar(12) DEFAULT NULL,
  `oldSeat` varchar(12) DEFAULT NULL,
  `orderNumber` varchar(32) DEFAULT NULL,
  `orderStatus` varchar(32) DEFAULT NULL,
  `orderType` int(11) DEFAULT NULL,
  `original` varchar(20) DEFAULT NULL,
  `passengerName` varchar(32) DEFAULT NULL,
  `passengerPhone` varchar(15) DEFAULT NULL,
  `passengerTicketName` varchar(64) DEFAULT NULL,
  `payType` varchar(12) DEFAULT NULL,
  `purserCellphone` varchar(15) DEFAULT NULL,
  `purserName` varchar(32) DEFAULT NULL,
  `cardNOMask` varchar(24) DEFAULT NULL,
  `expDate` varchar(12) DEFAULT NULL,
  `offTransDate` varchar(12) DEFAULT NULL,
  `offTransTime` varchar(12) DEFAULT NULL,
  `terminalID` varchar(12) DEFAULT NULL,
  `responseCode` varchar(12) DEFAULT NULL,
  `responseDesc` varchar(32) DEFAULT NULL,
  `sysUniqueID` varchar(32) DEFAULT NULL,
  `secondaryContact` varchar(12) DEFAULT NULL,
  `secondaryPhone` varchar(15) DEFAULT NULL,
  `serialNumber` varchar(32) DEFAULT NULL,
  `totalMoney` double DEFAULT NULL,
  `uniqueCode` varchar(12) DEFAULT NULL,
  `type` varchar(12) DEFAULT NULL,
  `payStatus` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `otherPhone` varchar(20) DEFAULT NULL,
  `idCard` varchar(26) DEFAULT NULL,
  `imgUpload` longtext,
  `address` varchar(150) DEFAULT NULL,
  `orderDescript` varchar(150) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_trade_orders_seat_boc_orderNumber` (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=4005 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_orders_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_orders_zfb`;
CREATE TABLE `trade_orders_zfb` (
  `id` varchar(32) NOT NULL,
  `outTradeNo` varchar(32) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `totalAmount` float DEFAULT NULL,
  `undiscountableAmount` int(11) DEFAULT '0' COMMENT '优惠前价格单位分',
  `sellerId` varchar(32) DEFAULT NULL,
  `body` varchar(300) DEFAULT NULL,
  `operatorId` varchar(32) DEFAULT NULL,
  `storeId` varchar(32) DEFAULT NULL,
  `authCode` varchar(32) DEFAULT NULL,
  `businessType` varchar(12) DEFAULT NULL,
  `paystatus` varchar(4) DEFAULT '' COMMENT '支付状态0未支付1支付成功2支付失败3已经退款4订单作废',
  `supplierguid` varchar(32) DEFAULT NULL COMMENT '供应商id',
  `beanCount` int(11) DEFAULT NULL COMMENT '乐豆数量',
  `buyername` varchar(32) DEFAULT NULL COMMENT '买家姓名',
  `tele` varchar(32) DEFAULT NULL COMMENT '买家电话',
  `area` varchar(24) DEFAULT NULL COMMENT '地区',
  `consigneeName` varchar(32) DEFAULT NULL COMMENT '收获人姓名',
  `consigneeTelephone` varchar(20) DEFAULT NULL COMMENT '收货人地址',
  `address` varchar(128) DEFAULT NULL COMMENT '地址',
  `email` varchar(64) DEFAULT NULL COMMENT '买家邮箱',
  `userId` varchar(32) DEFAULT NULL COMMENT '用户id后四位',
  `submitTime` varchar(20) DEFAULT NULL COMMENT '订单提交时间yyMMddHHmmss',
  `discountAmount` int(11) DEFAULT '0' COMMENT '优惠金额单位分',
  `refundAmount` int(11) DEFAULT '0' COMMENT '退款金额单位分',
  `idCard` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `version` varchar(4) DEFAULT NULL COMMENT '0pc无短信1pc有短信2app无短信3app有短信',
  `ip` varchar(20) DEFAULT NULL,
  `airCompany` varchar(12) DEFAULT NULL COMMENT '航渠',
  `updatetime` datetime DEFAULT NULL,
  `flightNumber` varchar(20) DEFAULT NULL COMMENT '航班号',
  `flightPhase` varchar(20) DEFAULT NULL COMMENT '航段',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trade_orders_zfb_outTradeNo_unique` (`outTradeNo`) USING BTREE,
  KEY `index_trade_orders_zfb_outTradeNo` (`outTradeNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调用支付宝生成二维码，所需订单信息   还有其他支付包订单信息';

-- ----------------------------
-- Table structure for trade_refund_details_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_refund_details_zfb`;
CREATE TABLE `trade_refund_details_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(32) DEFAULT NULL,
  `trade_no` varchar(32) DEFAULT NULL,
  `result_details` varchar(100) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trade_refund_details_zfb_batch_no` (`batch_no`),
  KEY `trade_refund_details_zfb_trade_no` (`trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8mb4 COMMENT='支付宝无短信验证退款';

-- ----------------------------
-- Table structure for trade_refund_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_refund_zfb`;
CREATE TABLE `trade_refund_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notify_time` varchar(32) DEFAULT NULL,
  `notify_type` varchar(32) DEFAULT NULL,
  `notify_id` varchar(64) DEFAULT NULL,
  `sign_type` varchar(12) DEFAULT NULL,
  `sign` varchar(350) DEFAULT NULL,
  `batch_no` varchar(32) DEFAULT NULL,
  `success_num` varchar(4) DEFAULT NULL,
  `result_details` varchar(500) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COMMENT='支付宝无短信验证退款';

-- ----------------------------
-- Table structure for trade_seatorder_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_seatorder_zfb`;
CREATE TABLE `trade_seatorder_zfb` (
  `id` char(32) NOT NULL,
  `outTradeNo` varchar(32) DEFAULT NULL,
  `date` varchar(24) DEFAULT NULL,
  `flightNumber` varchar(32) DEFAULT NULL,
  `moneyType` varchar(12) DEFAULT NULL,
  `newSeat` varchar(12) DEFAULT NULL,
  `oldSeat` varchar(12) DEFAULT NULL,
  `orderStatus` varchar(100) DEFAULT NULL,
  `passengerName` varchar(64) DEFAULT NULL,
  `passengerTicketName` varchar(128) DEFAULT NULL,
  `payType` varchar(12) DEFAULT NULL,
  `purserEmail` varchar(64) DEFAULT NULL,
  `purserName` varchar(64) DEFAULT NULL,
  `purserPhone` varchar(12) DEFAULT NULL,
  `serialNumber` varchar(32) DEFAULT NULL,
  `totalMoney` varchar(32) DEFAULT NULL,
  `type` varchar(12) DEFAULT NULL,
  `cabin` varchar(12) DEFAULT NULL,
  `flightPhase` varchar(32) DEFAULT NULL,
  `ipadress` varchar(32) DEFAULT NULL,
  `passengerPhone` varchar(32) DEFAULT NULL,
  `destination` varchar(64) DEFAULT NULL,
  `original` varchar(64) DEFAULT NULL,
  `purserCellphone` varchar(16) DEFAULT NULL,
  `invoiceTitle` varchar(100) DEFAULT NULL,
  `invoiceName` varchar(100) DEFAULT NULL,
  `invoiceCell` varchar(100) DEFAULT NULL,
  `invoiceAddress` varchar(100) DEFAULT NULL,
  `imgUpload` longtext,
  `uniqueCode` varchar(64) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `totalAmount` float DEFAULT NULL,
  `undiscountableAmount` float DEFAULT NULL,
  `sellerId` varchar(32) DEFAULT NULL,
  `body` varchar(300) DEFAULT NULL,
  `businessType` varchar(12) DEFAULT NULL,
  `paystatus` varchar(4) DEFAULT NULL,
  `submitTime` varchar(20) DEFAULT NULL,
  `version` varchar(4) DEFAULT NULL,
  `userId` varchar(4) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `orderFrom` varchar(10) DEFAULT NULL COMMENT '航渠 HU',
  `updatetime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trade_seatorder_zfb_orderNumber` (`outTradeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调用支付宝支付成功后详细订单  升舱';

-- ----------------------------
-- Table structure for trade_success_send_message
-- ----------------------------
DROP TABLE IF EXISTS `trade_success_send_message`;
CREATE TABLE `trade_success_send_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(32) DEFAULT NULL COMMENT '订单号',
  `mobile` text COMMENT '短信接收人，多个以，隔开',
  `extcode` varchar(20) DEFAULT NULL COMMENT '扩展号，如果需要短信报告以及回复功能必须填写此项 ',
  `senddate` varchar(20) DEFAULT NULL COMMENT '预约时间，如果为空代表即时发送 yyyyMMddHHmmss',
  `content` varchar(1000) DEFAULT NULL COMMENT '发送短信内容',
  `status` varchar(12) DEFAULT NULL COMMENT '发送状态',
  `flag` varchar(4) DEFAULT NULL,
  `messflag` int(11) DEFAULT '0' COMMENT '短信发送状态null 或0 未发送，1已发送',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=988 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for trade_synchro_zfb
-- ----------------------------
DROP TABLE IF EXISTS `trade_synchro_zfb`;
CREATE TABLE `trade_synchro_zfb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_succes` varchar(4) DEFAULT NULL COMMENT '成功标识',
  `sign_type` varchar(4) DEFAULT NULL,
  `sign` varchar(300) DEFAULT NULL,
  `out_trade_no` varchar(64) DEFAULT NULL COMMENT '商户网站唯一订单号',
  `subject` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `payment_type` varchar(4) DEFAULT NULL,
  `trade_no` varchar(64) DEFAULT NULL,
  `trade_status` varchar(32) DEFAULT NULL,
  `notify_time` varchar(20) DEFAULT NULL,
  `notify_type` varchar(32) DEFAULT NULL,
  `seller_id` varchar(20) DEFAULT NULL,
  `total_fee` float DEFAULT NULL,
  `body` varchar(200) DEFAULT NULL,
  `extra_common_param` varchar(200) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `payflag` varchar(4) DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alipay_unmessage_synchro_out_trade_no` (`out_trade_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=473 DEFAULT CHARSET=utf8mb4 COMMENT='页面跳转同步通知参数说明';

-- ----------------------------
-- Table structure for txt_context_boc
-- ----------------------------
DROP TABLE IF EXISTS `txt_context_boc`;
CREATE TABLE `txt_context_boc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relativeTime` date DEFAULT NULL,
  `terminalNum` varchar(12) DEFAULT NULL,
  `batch` varchar(32) DEFAULT NULL,
  `cardNumber` varchar(32) DEFAULT NULL,
  `transDate` varchar(32) DEFAULT NULL,
  `transTime` varchar(32) DEFAULT NULL,
  `tranAmount` double DEFAULT NULL,
  `tranFee` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `empowerNum` varchar(32) DEFAULT NULL,
  `tranCode` varchar(32) DEFAULT NULL,
  `byStages` varchar(32) DEFAULT NULL,
  `cbin` varchar(32) DEFAULT NULL,
  `referenceNum` varchar(32) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL COMMENT 'txt_upload_boc 中对应的文件',
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `txt_context_boc_cardNumberreferenceNum` (`cardNumber`,`referenceNum`),
  KEY `boc_txt_sRefNo_sAuthCode` (`referenceNum`,`empowerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=7455 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for txt_upload_boc
-- ----------------------------
DROP TABLE IF EXISTS `txt_upload_boc`;
CREATE TABLE `txt_upload_boc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(11) DEFAULT NULL,
  `fileName` varchar(200) DEFAULT NULL,
  `newFilename` varchar(200) DEFAULT NULL,
  `fileUrl` varchar(200) DEFAULT NULL,
  `fileState` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `flag` varchar(12) DEFAULT NULL,
  `status` varchar(12) DEFAULT NULL,
  `relativeTime` date DEFAULT NULL COMMENT '这是取的txt文档上传的那一号的',
  `uploadTime` datetime DEFAULT NULL,
  `savetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- View structure for view_api_orders
-- ----------------------------
DROP VIEW IF EXISTS `view_api_orders`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_api_orders` AS select `tos`.`id` AS `id`,`tos`.`orderNumber` AS `orderNumber`,`tos`.`buyerName` AS `buyerName`,`tos`.`buyerTelephone` AS `buyerTelephone`,`tos`.`buyerEmail` AS `buyerEmail`,`tos`.`address` AS `address`,`tos`.`memo` AS `memo`,`tos`.`idCard` AS `idCard`,`tos`.`device` AS `device`,`tos`.`paytype` AS `paytype`,`tos`.`activePartition` AS `activePartition`,`tos`.`orderFrom` AS `orderFrom`,`tos`.`mbdMonth` AS `mbdMonth`,`tos`.`totalAmount` AS `totalAmount`,`tos`.`totalAmountStr` AS `totalAmountStr`,`tos`.`ordertime` AS `ordertime`,`tos`.`consigneeName` AS `consigneeName`,`tos`.`consigneeTelephone` AS `consigneeTelephone`,`tos`.`blessing` AS `blessing`,`tos`.`status` AS `status`,`tos`.`email` AS `email`,`tos`.`ip` AS `ip`,`tos`.`updatetime` AS `updatetime`,`tos`.`flightNumber` AS `flightNumber`,`tos`.`flightPhase` AS `flightPhase`,`tos`.`company` AS `company`,`tos`.`payStatus` AS `payStatus`,`tos`.`refundAmount` AS `refundAmount`,`tos`.`discountAmount` AS `discountAmount`,`tos`.`undiscountableAmount` AS `undiscountableAmount`,`tos`.`savetime` AS `savetime`,`tgs`.`goodsId` AS `goodsId`,`tgs`.`goodsName` AS `goodsName`,`tgs`.`price` AS `price`,`tgs`.`quantity` AS `quantity`,`tgs`.`goodsSize` AS `goodsSize`,`tgs`.`discountAmount` AS `goodsDiscountAmount`,`tgs`.`supplierguid` AS `supplierguid`,`tgs`.`isDelete` AS `isDelete`,`tl`.`logisticsId` AS `logisticsId`,`tl`.`logisticsCompany` AS `logisticsCompany`,`tl`.`logisticsType` AS `logisticsType`,`tl`.`memo` AS `logisticsMemo`,`tl`.`sendtime` AS `sendtime` from ((`trade_orders` `tos` left join `trade_goods` `tgs` on((convert(`tos`.`orderNumber` using utf8mb4) = `tgs`.`orderNumber`))) left join `trade_logistics` `tl` on((convert(`tos`.`orderNumber` using utf8mb4) = `tl`.`orderNumber`))) ;

-- ----------------------------
-- View structure for view_download_terminfo
-- ----------------------------
DROP VIEW IF EXISTS `view_download_terminfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_download_terminfo` AS select `fd`.`id` AS `id`,`fd`.`serialNumber` AS `serialNumber`,`fd`.`macId` AS `macId`,`fd`.`sdk_int` AS `sdk_int`,`fd`.`productName` AS `productName`,`fd`.`deviceName` AS `deviceName`,`fd`.`osVersion` AS `osVersion`,`fd`.`identification` AS `identification`,`fd`.`apkVersionName` AS `apkVersionName`,`fd`.`apkVersionCode` AS `apkVersionCode`,`fd`.`airCompany` AS `airCompany`,`fd`.`downflag` AS `downflag`,`fd`.`status` AS `status`,`fd`.`exAirCompany` AS `exAirCompany`,`fd`.`exApkVersionName` AS `exApkVersionName`,`fd`.`timediff` AS `timediff`,`fd`.`updatetime` AS `updatetime`,`fd`.`savetime` AS `savetime`,`ti`.`termId` AS `termId`,`ti`.`mposId` AS `mposId`,`ti`.`cityName` AS `cityName` from (`file_download` `fd` left join `term_info` `ti` on((`fd`.`macId` = `ti`.`mac`))) ;

-- ----------------------------
-- View structure for view_goods_info_jxt
-- ----------------------------
DROP VIEW IF EXISTS `view_goods_info_jxt`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_goods_info_jxt` AS select `goods_info_jxt`.`id` AS `id`,`goods_info_jxt`.`goods_id` AS `goods_id`,`goods_info_jxt`.`goods_name` AS `goods_name`,`goods_info_jxt`.`title` AS `title`,`goods_info_jxt`.`status` AS `STATUS`,`goods_info_jxt`.`type` AS `type`,`goods_info_jxt`.`send_type` AS `send_type`,`goods_info_jxt`.`pay_type` AS `pay_type`,`goods_info_jxt`.`amount` AS `amount`,`goods_info_jxt`.`sku_user_price` AS `sku_user_price`,`goods_info_jxt`.`sku_back_cash` AS `sku_back_cash`,`goods_info_jxt`.`sku_market_price` AS `sku_market_price`,`goods_info_jxt`.`sku_suggest_price` AS `sku_suggest_price`,`goods_info_jxt`.`refund_type` AS `refund_type`,`goods_info_jxt`.`validity_type` AS `validity_type`,`goods_info_jxt`.`validity_day` AS `validity_day`,`goods_info_jxt`.`validity_time` AS `validity_time`,`goods_info_jxt`.`start_time` AS `start_time`,`goods_info_jxt`.`expire_time` AS `expire_time`,`goods_info_jxt`.`description` AS `description`,`goods_info_jxt`.`descriptionPath` AS `descriptionPath`,`goods_info_jxt`.`brief` AS `brief`,`goods_info_jxt`.`notice` AS `notice`,`goods_info_jxt`.`image` AS `image`,`goods_info_jxt`.`category_group_name` AS `category_group_name`,`goods_info_jxt`.`last_order_time` AS `last_order_time`,`goods_info_jxt`.`week` AS `week`,`goods_info_jxt`.`max_num` AS `max_num`,`goods_info_jxt`.`min_num` AS `min_num`,`goods_info_jxt`.`must_id_number` AS `must_id_number`,`goods_info_jxt`.`refund_chanrge_type` AS `refund_chanrge_type`,`goods_info_jxt`.`refund_chanrge` AS `refund_chanrge`,`goods_info_jxt`.`self_refund_scale` AS `self_refund_scale`,`goods_info_jxt`.`self_refund_fixed` AS `self_refund_fixed`,`goods_info_jxt`.`last_order_date` AS `last_order_date`,`goods_info_jxt`.`flag` AS `flag`,`goods_info_jxt`.`updatetime` AS `updatetime`,`goods_info_jxt`.`savetime` AS `savetime` from `goods_info_jxt` ;

-- ----------------------------
-- View structure for view_goods_info_jxt_export
-- ----------------------------
DROP VIEW IF EXISTS `view_goods_info_jxt_export`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_goods_info_jxt_export` AS select `gi`.`id` AS `id`,`gi`.`goods_id` AS `goods_id`,`gi`.`goods_name` AS `goods_name`,`gi`.`title` AS `title`,`gi`.`status` AS `status`,`gi`.`type` AS `type`,`gi`.`send_type` AS `send_type`,`gi`.`pay_type` AS `pay_type`,`gi`.`amount` AS `amount`,`gi`.`sku_user_price` AS `sku_user_price`,`gi`.`sku_back_cash` AS `sku_back_cash`,`gi`.`sku_market_price` AS `sku_market_price`,`gi`.`sku_suggest_price` AS `sku_suggest_price`,`gi`.`refund_type` AS `refund_type`,`gi`.`validity_type` AS `validity_type`,`gi`.`validity_day` AS `validity_day`,`gi`.`validity_time` AS `validity_time`,`gi`.`start_time` AS `start_time`,`gi`.`expire_time` AS `expire_time`,`gi`.`description` AS `description`,`gi`.`descriptionPath` AS `descriptionPath`,`gi`.`brief` AS `brief`,`gi`.`notice` AS `notice`,`gi`.`image` AS `image`,`gi`.`imagePath` AS `imagePath`,`gi`.`category_group_name` AS `category_group_name`,`gi`.`last_order_time` AS `last_order_time`,`gi`.`week` AS `week`,`gi`.`max_num` AS `max_num`,`gi`.`min_num` AS `min_num`,`gi`.`must_id_number` AS `must_id_number`,`gi`.`refund_chanrge_type` AS `refund_chanrge_type`,`gi`.`refund_chanrge` AS `refund_chanrge`,`gi`.`self_refund_scale` AS `self_refund_scale`,`gi`.`self_refund_fixed` AS `self_refund_fixed`,`gi`.`last_order_date` AS `last_order_date`,`gi`.`flag` AS `flag`,`gi`.`updatetime` AS `updatetime`,`gi`.`savetime` AS `savetime`,`gis`.`goods_info_id` AS `goods_info_id`,`gis`.`supplier_id` AS `supplier_id`,`gis`.`address` AS `address`,`gis`.`info` AS `info`,`gis`.`city` AS `city`,`gis`.`province` AS `province`,`gis`.`city_name` AS `city_name`,`gis`.`province_name` AS `province_name`,`gis`.`lng_lat` AS `lng_lat` from (`goods_info_jxt` `gi` left join `goods_info_supplier_jxt` `gis` on((`gi`.`goods_id` = `gis`.`goods_info_id`))) where ((`gi`.`flag` = 0) and (ifnull(`gi`.`imagePath`,'') <> '') and (ifnull(`gi`.`descriptionPath`,'') <> '')) ;

-- ----------------------------
-- View structure for view_goods_info_response_kl
-- ----------------------------
DROP VIEW IF EXISTS `view_goods_info_response_kl`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_goods_info_response_kl` AS select `gk`.`id` AS `id`,`gk`.`brandCountryName` AS `brandCountryName`,`gk`.`brandName` AS `brandName`,`gk`.`category` AS `category`,`gk`.`detail` AS `detail`,`gk`.`detailStr` AS `detailStr`,`gk`.`goodsId` AS `goodsId`,`gk`.`imageUrlStr` AS `imageUrlStr`,`gk`.`importType` AS `importType`,`gk`.`isSelf` AS `isSelf`,`gk`.`marketPrice` AS `marketPrice`,`gk`.`price` AS `price`,`gk`.`shortTitle` AS `shortTitle`,`gk`.`skuId` AS `skuId`,`gk`.`suggestPrice` AS `suggestPrice`,`gk`.`taxFees` AS `taxFees`,`gk`.`taxRate` AS `taxRate`,`gk`.`thirdCategoryName` AS `thirdCategoryName`,`gk`.`title` AS `title`,`gk`.`warehouseStore` AS `warehouseStore`,`gk`.`warehouseId` AS `warehouseId` from `goods_info_response_kl` `gk` where ((`gk`.`flag` = 0) and (`gk`.`onlineStatus` = 1)) ;

-- ----------------------------
-- View structure for view_ledou_export
-- ----------------------------
DROP VIEW IF EXISTS `view_ledou_export`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_ledou_export` AS select `ppl`.`id` AS `id`,`ppl`.`orderNumber` AS `orderNumber`,`ppl`.`outTradeNo` AS `outTradeNo`,`ppl`.`customeName` AS `customeName`,`ppl`.`customePhone` AS `customePhone`,`ppl`.`totalPrice` AS `totalPrice`,`ppl`.`payMoney` AS `payMoney`,`ppl`.`beanCount` AS `beanCount`,`ppl`.`payType` AS `payType`,`ppl`.`goodsName` AS `goodsName`,`ppl`.`discountAmount` AS `discountAmount`,`ppl`.`savetime` AS `savetime`,`tos`.`payStatus` AS `payStatus` from (`portal_pay_ledou` `ppl` left join `trade_orders` `tos` on((`ppl`.`orderNumber` = convert(`tos`.`orderNumber` using utf8mb4)))) ;

-- ----------------------------
-- View structure for view_order_notify
-- ----------------------------
DROP VIEW IF EXISTS `view_order_notify`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_order_notify` AS select `tos`.`id` AS `id`,`tos`.`orderNumber` AS `orderNumber`,`tos`.`buyerName` AS `buyerName`,`tos`.`buyerTelephone` AS `buyerTelephone`,`tos`.`address` AS `address`,`tos`.`idCard` AS `idCard`,`tos`.`paytype` AS `paytype`,`tos`.`orderFrom` AS `orderFrom`,`tos`.`totalAmount` AS `totalAmount`,`tos`.`consigneeName` AS `consigneeName`,`tos`.`consigneeTelephone` AS `consigneeTelephone`,`tos`.`blessing` AS `blessing`,`tos`.`status` AS `status`,`tos`.`email` AS `email`,`tos`.`payStatus` AS `payStatus`,`tos`.`refundAmount` AS `refundAmount`,`tos`.`discountAmount` AS `discountAmount`,`tos`.`undiscountableAmount` AS `undiscountableAmount`,`tos`.`savetime` AS `savetime`,`tgs`.`goodsId` AS `goodsId`,`tgs`.`goodsName` AS `goodsName`,`tgs`.`price` AS `price`,`tgs`.`quantity` AS `quantity`,`tgs`.`goodsSize` AS `goodsSize`,`tgs`.`discountAmount` AS `discountAmountGoods`,`tgs`.`supplierguid` AS `supplierguid`,`tnsu`.`url` AS `url` from (((`trade_orders` `tos` left join `trade_goods` `tgs` on((convert(`tos`.`orderNumber` using utf8mb4) = `tgs`.`orderNumber`))) left join `trade_notify_supplier_url` `tnsu` on((`tgs`.`supplierguid` = `tnsu`.`supplierguid`))) left join `trade_notify_result` `tnr` on(((convert(`tos`.`orderNumber` using utf8mb4) = `tnr`.`orderNumber`) and (`tgs`.`supplierguid` = `tnr`.`supplierId`)))) where ((`tnsu`.`supplierguid` is not null) and (`tos`.`savetime` >= (sysdate() - interval 31 day)) and (`tnsu`.`flag` = 0) and (`tos`.`company` = 'xilehang') and (isnull(`tnr`.`orderSendStatus`) or (`tnr`.`orderSendStatus` <> 1))) order by `tos`.`id` desc ;

-- ----------------------------
-- View structure for view_order_payresult_notify
-- ----------------------------
DROP VIEW IF EXISTS `view_order_payresult_notify`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_order_payresult_notify` AS select `tos`.`orderNumber` AS `orderNumber`,`tos`.`payStatus` AS `payStatus`,`tos`.`savetime` AS `savetime`,`tgs`.`goodsId` AS `goodsId`,`tgs`.`goodsName` AS `goodsName`,`tgs`.`price` AS `price`,`tgs`.`quantity` AS `quantity`,`tgs`.`goodsSize` AS `goodsSize`,`tgs`.`isDelete` AS `isDelete`,`tgs`.`discountAmount` AS `discountAmountGoods`,`tgs`.`supplierguid` AS `supplierguid`,`tnsu`.`url` AS `url`,`tnr`.`orderSendStatus` AS `orderSendStatus`,`tnr`.`paySuccessSendStatus` AS `paySuccessSendStatus`,`tnr`.`payFailSendStatus` AS `payFailSendStatus`,`tnr`.`payRefundSendStatus` AS `payRefundSendStatus` from (((`trade_orders` `tos` left join `trade_goods` `tgs` on((convert(`tos`.`orderNumber` using utf8mb4) = `tgs`.`orderNumber`))) left join `trade_notify_supplier_url` `tnsu` on((`tgs`.`supplierguid` = `tnsu`.`supplierguid`))) left join `trade_notify_result` `tnr` on(((convert(`tos`.`orderNumber` using utf8mb4) = `tnr`.`orderNumber`) and (`tgs`.`supplierguid` = `tnr`.`supplierId`)))) where ((`tnsu`.`supplierguid` is not null) and (`tnsu`.`flag` = 0) and (`tos`.`company` = 'xilehang')) order by `tos`.`id` desc ;

-- ----------------------------
-- View structure for view_portal_pay_order
-- ----------------------------
DROP VIEW IF EXISTS `view_portal_pay_order`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_portal_pay_order` AS select `po`.`id` AS `id`,`po`.`orderNumber` AS `orderNumber`,`po`.`activePartition` AS `activePartition`,`po`.`commission` AS `commission`,`po`.`count` AS `count`,`po`.`customerName` AS `customerName`,`po`.`customerCellphone` AS `customerCellphone`,`po`.`customerEmail` AS `customerEmail`,`po`.`purserCellphone` AS `purserCellphone`,`po`.`orderStatus` AS `orderStatus`,`po`.`orderFrom` AS `orderFrom`,`po`.`orderType` AS `orderType`,`po`.`original` AS `original`,`po`.`deviceType` AS `deviceType`,`po`.`flightPhase` AS `flightPhase`,`po`.`flyBless` AS `flyBless`,`po`.`iDNumber` AS `iDNumber`,`po`.`indroduction` AS `indroduction`,`po`.`printFlightPhase` AS `printFlightPhase`,`po`.`secondaryContact` AS `secondaryContact`,`po`.`secondaryPhone` AS `secondaryPhone`,`po`.`secretMonth` AS `secretMonth`,`po`.`serialNumber` AS `serialNumber`,`po`.`totalMoney` AS `totalMoney`,`po`.`customerAddress` AS `customerAddress`,`po`.`unitPrice` AS `unitPrice`,`po`.`upload` AS `upload`,`po`.`date` AS `date`,`po`.`flightNumber` AS `flightNumber`,`po`.`originPlace` AS `originPlace`,`po`.`destination` AS `destination`,`po`.`purserName` AS `purserName`,`po`.`cellphone` AS `cellphone`,`po`.`purserEmail` AS `purserEmail`,`po`.`payType` AS `payType`,`po`.`newSeat` AS `newSeat`,`po`.`oldSeat` AS `oldSeat`,`po`.`payflag` AS `payflag`,`po`.`cabin` AS `cabin`,`po`.`moneyType` AS `moneyType`,`po`.`passengerName` AS `passengerName`,`po`.`passengerPhone` AS `passengerPhone`,`po`.`passengerTicketName` AS `passengerTicketName`,`po`.`type` AS `type`,`po`.`uniqueCode` AS `uniqueCode`,`po`.`invoiceTitle` AS `invoiceTitle`,`po`.`invoiceName` AS `invoiceName`,`po`.`invoiceCell` AS `invoiceCell`,`po`.`invoiceAddress` AS `invoiceAddress`,`po`.`payStatus` AS `payStatus`,`po`.`savetime` AS `savetime`,`pc`.`stateCode` AS `stateCode` from (`portal_pay_order` `po` left join `portal_pay_callback` `pc` on((`po`.`orderNumber` = `pc`.`merOrderId`))) ;

-- ----------------------------
-- View structure for view_sys_user
-- ----------------------------
DROP VIEW IF EXISTS `view_sys_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_sys_user` AS select `su`.`id` AS `id`,`su`.`loginname` AS `loginname`,`su`.`name` AS `name`,`su`.`password` AS `password`,`su`.`customer_id` AS `customer_id`,`su`.`sex` AS `sex`,`su`.`age` AS `age`,`su`.`usertype` AS `usertype`,`su`.`isdefault` AS `isdefault`,`su`.`state` AS `state`,`su`.`organization_id` AS `organization_id`,`su`.`createdatetime` AS `createdatetime`,`su`.`phone` AS `phone`,`su`.`airCompany` AS `airCompany`,`su`.`supplier_id` AS `supplier_id`,`so`.`name` AS `organizationName` from (`sys_user` `su` left join `sys_organization` `so` on((`su`.`organization_id` = `so`.`id`))) ;

-- ----------------------------
-- View structure for view_trade_cart_wx_export2
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_cart_wx_export2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_cart_wx_export2` AS select `sc`.`orderNumber` AS `orderNumber`,'' AS `original`,'' AS `destination`,`sc`.`orderFrom` AS `airCompany`,'' AS `flightNumber`,'' AS `flightDate`,`sc`.`savetime` AS `receiveDate`,`oic`.`supplierguid` AS `supplierguid`,`oic`.`goodsId` AS `goodsId`,`oic`.`quantity` AS `goodsCount`,`oic`.`price` AS `price`,`sc`.`buyerName` AS `customerName`,`sc`.`buyerTelephone` AS `telephone`,`sc`.`totalAmount` AS `totalMoney`,'' AS `fee`,'' AS `beanCount`,'' AS `logisticsCompany`,'' AS `logisticsId`,`sc`.`savetime` AS `savetime` from (`trade_orders` `sc` left join `trade_goods` `oic` on((convert(`sc`.`orderNumber` using utf8mb4) = `oic`.`orderNumber`))) where ((`sc`.`payStatus` = 1) and (`sc`.`paytype` = 2)) ;

-- ----------------------------
-- View structure for view_trade_portalpay_dz
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_portalpay_dz`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_portalpay_dz` AS select `ppo`.`id` AS `id`,`ppo`.`orderNumber` AS `orderNumber`,`ppo`.`savetime` AS `savetime`,`ppo`.`supplierguid` AS `supplierguid`,`ppog`.`goodsId` AS `goodsId`,`ppog`.`goodsName` AS `goodsName`,`ppog`.`goodsSize` AS `goodsSize`,`ppog`.`goodsCount` AS `goodsCount`,`ppog`.`goodsMoney` AS `goodsMoney`,`ppo`.`passengerName` AS `passengerName`,`ppo`.`totalMoney` AS `totalMoney`,`ppo`.`orderFrom` AS `orderFrom`,`tl`.`logisticsCompany` AS `logisticsCompany`,`tl`.`logisticsId` AS `logisticsId` from ((`portal_pay_order` `ppo` left join `portal_pay_order_goods` `ppog` on((`ppo`.`orderNumber` = `ppog`.`orderNumber`))) left join `trade_logistics` `tl` on((`ppo`.`orderNumber` = `tl`.`orderNumber`))) where ((`ppo`.`type` = 'cart') and (`ppo`.`payStatus` = '2')) ;

-- ----------------------------
-- View structure for view_trade_portalpay_dz2
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_portalpay_dz2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_portalpay_dz2` AS select `ppo`.`orderNumber` AS `orderNumber`,'' AS `original`,'' AS `destination`,`ppo`.`orderFrom` AS `airCompany`,'' AS `flightNumber`,'' AS `flightDate`,`ppo`.`date` AS `receiveDate`,`ppog`.`supplierguid` AS `supplierguid`,`ppog`.`goodsId` AS `goodsId`,`ppog`.`goodsCount` AS `goodsCount`,`ppog`.`goodsMoney` AS `price`,`ppo`.`passengerName` AS `customerName`,`ppo`.`passengerPhone` AS `telephone`,`ppo`.`totalMoney` AS `totalMoney`,'' AS `fee`,'' AS `beanCount`,`ppo`.`orderFrom` AS `orderFrom`,`tl`.`logisticsCompany` AS `logisticsCompany`,`tl`.`logisticsId` AS `logisticsId`,`ppo`.`savetime` AS `savetime`,`ppc`.`payType` AS `payType` from (((`portal_pay_order` `ppo` left join `portal_pay_order_goods` `ppog` on((`ppo`.`orderNumber` = `ppog`.`orderNumber`))) left join `trade_logistics` `tl` on((`ppo`.`orderNumber` = `tl`.`orderNumber`))) left join `portal_pay_callback` `ppc` on((`ppo`.`orderNumber` = `ppc`.`merOrderId`))) where ((`ppo`.`type` = 'cart') and (`ppo`.`payStatus` = '2') and (`ppo`.`company` = 'xilehang')) ;

-- ----------------------------
-- View structure for view_trade_seatorder_dz2
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_seatorder_dz2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_seatorder_dz2` AS select `tsz`.`outTradeNo` AS `orderNumber`,`tsz`.`type` AS `type`,`tsz`.`flightPhase` AS `flightPhase`,`tsz`.`flightNumber` AS `flightNumber`,cast(`tsz`.`totalMoney` as decimal(10,2)) AS `totalMoney`,`tsz`.`orderStatus` AS `orderStatus`,`tsz`.`passengerName` AS `customerName`,`tsz`.`passengerPhone` AS `telephone`,`tsz`.`savetime` AS `savetime` from `trade_seatorder_zfb` `tsz` where ((`tsz`.`paystatus` = '1') and (`tsz`.`totalMoney` is not null)) ;

-- ----------------------------
-- View structure for view_trade_success_message_resource
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_success_message_resource`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_success_message_resource` AS select `tos`.`id` AS `id`,`tos`.`orderNumber` AS `orderNumber`,`tos`.`buyerName` AS `buyerName`,`tos`.`buyerTelephone` AS `buyerTelephone`,`tos`.`buyerEmail` AS `email`,`tos`.`totalAmount` AS `totalAmount`,`tos`.`ip` AS `ip`,`tos`.`savetime` AS `savetime`,`tg`.`goodsName` AS `goodsName`,`tg`.`goodsId` AS `goodsId`,`tg`.`supplierguid` AS `supplierguid`,`tg`.`price` AS `price` from (`trade_orders` `tos` left join `trade_goods` `tg` on((convert(`tos`.`orderNumber` using utf8mb4) = `tg`.`orderNumber`))) ;

-- ----------------------------
-- View structure for view_trade_zfb_dz
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_zfb_dz`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_zfb_dz` AS select `toz`.`id` AS `id`,`toz`.`outTradeNo` AS `outTradeNo`,`toz`.`savetime` AS `savetime`,`toz`.`supplierguid` AS `supplierguid`,`tgz`.`goodsName` AS `goodsName`,`tgz`.`goodsSize` AS `goodsSize`,`tgz`.`quantity` AS `quantity`,`tgz`.`price` AS `price`,`toz`.`buyername` AS `buyername`,`toz`.`totalAmount` AS `totalAmount`,`toz`.`airCompany` AS `airCompany`,`tl`.`logisticsCompany` AS `logisticsCompany`,`tl`.`logisticsId` AS `logisticsId` from ((`trade_orders_zfb` `toz` left join `trade_goods_zfb` `tgz` on((convert(`toz`.`outTradeNo` using utf8mb4) = `tgz`.`outTradeNo`))) left join `trade_logistics` `tl` on((convert(`toz`.`outTradeNo` using utf8mb4) = `tl`.`orderNumber`))) where (`toz`.`paystatus` = '1') ;

-- ----------------------------
-- View structure for view_trade_zfb_dz2
-- ----------------------------
DROP VIEW IF EXISTS `view_trade_zfb_dz2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_trade_zfb_dz2` AS select `toz`.`outTradeNo` AS `orderNumber`,'' AS `original`,'' AS `destination`,'' AS `flightNumber`,'' AS `flightDate`,'' AS `receiveDate`,`tgz`.`supplierguid` AS `supplierguid`,`tgz`.`goodsId` AS `goodsId`,`tgz`.`quantity` AS `goodsCount`,`tgz`.`price` AS `price`,`toz`.`buyername` AS `customerName`,`toz`.`tele` AS `telephone`,`toz`.`totalAmount` AS `totalMoney`,'' AS `fee`,'' AS `beanCount`,'' AS `orderFrom`,`toz`.`airCompany` AS `airCompany`,`tl`.`logisticsCompany` AS `logisticsCompany`,`tl`.`logisticsId` AS `logisticsId`,`toz`.`savetime` AS `savetime` from ((`trade_orders_zfb` `toz` left join `trade_goods_zfb` `tgz` on((convert(`toz`.`outTradeNo` using utf8mb4) = `tgz`.`outTradeNo`))) left join `trade_logistics` `tl` on((convert(`toz`.`outTradeNo` using utf8mb4) = `tl`.`orderNumber`))) where (`toz`.`paystatus` = '1') ;

-- ----------------------------
-- View structure for view_yongle_json_export
-- ----------------------------
DROP VIEW IF EXISTS `view_yongle_json_export`;
CREATE ALGORITHM=UNDEFINED DEFINER=`paymanager`@`%` SQL SECURITY DEFINER VIEW `view_yongle_json_export` AS select `fiy`.`citycode` AS `citycode`,`fiy`.`playCity` AS `cityName`,`piy`.`productId` AS `productId`,`piy`.`status` AS `STATUS`,`piy`.`playName` AS `playName`,`piy`.`nameSynonym` AS `nameSynonym`,`piy`.`shelfStatus` AS `shelfStatus`,`piy`.`trueBuy` AS `trueBuy`,`piy`.`fconfigId` AS `fconfigId`,`piy`.`playCityId` AS `playCityId`,`piy`.`playCityCode` AS `playCityCode`,`piy`.`playCity` AS `playCity`,`piy`.`playAddressId` AS `playAddressId`,`piy`.`playAddress` AS `playAddress`,`piy`.`playTypeAId` AS `playTypeAId`,`piy`.`playTypeBId` AS `playTypeBId`,`piy`.`playTypeA` AS `playTypeA`,`piy`.`playTypeB` AS `playTypeB`,`piy`.`productPicture` AS `productPicture`,`piy`.`productPictureLocal` AS `productPictureLocal`,`piy`.`seatPicture` AS `seatPicture`,`piy`.`productStartTime` AS `productStartTime`,`piy`.`productEndTime` AS `productEndTime`,`piy`.`venueMap` AS `venueMap`,`piy`.`venueStall` AS `venueStall`,`dly`.`dzp_dispatchWay` AS `dzp_dispatchWay`,`dly`.`dzp_type` AS `dzp_type`,`dly`.`dzp_message` AS `dzp_message`,`dly`.`smzq_dispatchWay` AS `smzq_dispatchWay`,`dly`.`smzq_address` AS `smzq_address`,`dly`.`smzq_time` AS `smzq_time`,`dly`.`smzq_message` AS `smzq_message`,`dly`.`kdps_dispatchWay` AS `kdps_dispatchWay`,`dly`.`kdps_message` AS `kdps_message`,`tiy`.`ticketTime` AS `ticketTime`,`tsiy`.`productPlayid` AS `productPlayid`,`tsiy`.`price` AS `price`,`tsiy`.`priceInfo` AS `priceInfo`,`tsiy`.`priceStarus` AS `priceStarus`,`tsiy`.`priceType` AS `priceType`,`tsiy`.`priceNum` AS `priceNum`,`piy`.`Sharedescribe` AS `Sharedescribe`,`piy`.`venueIntroduction` AS `venueIntroduction` from ((((`fconfig_info_yl` `fiy` left join `product_info_yl` `piy` on((`fiy`.`citycode` = `piy`.`playCityCode`))) left join `dispatchway_list_yl` `dly` on((`piy`.`productId` = `dly`.`productId`))) left join `tickettime_info_yl` `tiy` on((`piy`.`productId` = `tiy`.`productId`))) left join `tickset_info_yl` `tsiy` on((`tiy`.`id` = `tsiy`.`ticketTimeInfoId`))) where ((`piy`.`flag` = 0) and (`tiy`.`flag` = 0) and (`tsiy`.`flag` = 0) and (`dly`.`flag` = 0) and (`piy`.`shelfStatus` = 1) and (`tsiy`.`priceStarus` <> 2) and ((`tsiy`.`priceStarus` = 1) or (`tsiy`.`priceStarus` = 4)) and ((`tsiy`.`priceNum` = -(1)) or (`tsiy`.`priceNum` > 0)) and (`piy`.`playCityCode` = '023')) order by `piy`.`playCityId` ;

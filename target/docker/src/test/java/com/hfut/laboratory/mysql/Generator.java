package com.hfut.laboratory.mysql;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.ArrayList;
import java.util.List;

public class Generator {

    public static void main(String[] args) {

        AutoGenerator mpg = new AutoGenerator();
        // 选择 freemarker 引擎，默认 Velocity
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());

        /**
         * 全局配置
          */
        GlobalConfig gc = new GlobalConfig();
        gc.setAuthor("yzx");
        gc.setOutputDir("C:\\EXCS\\IDEA_exc\\accout-mange\\src\\main\\java\\del");
        gc.setFileOverride(false);// 是否覆盖同名文件，默认是false
        // 是否让每个实体类都继承Model 不需要ActiveRecord特性的请改为false
        gc.setActiveRecord(false);
        gc.setEnableCache(false);// XML 二级缓存
        gc.setBaseResultMap(true);// XML ResultMap
        gc.setBaseColumnList(true);// XML columList
        gc.setOpen(false); //是否每次打开文件夹

        //配置Service接口的名称 %s会自动填充
        gc.setServiceName("%sService");

        mpg.setGlobalConfig(gc);

        /**
         * 数据源配置
          */
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setDbType(DbType.MYSQL);
        dsc.setDriverName("com.mysql.jdbc.Driver");
        dsc.setUsername("root");
        dsc.setPassword("Yang2000620");
        dsc.setUrl("jdbc:mysql://localhost:3306/account-mange?useUnicode=true&serverTimezone=UTC&characterEncoding=utf8");
        mpg.setDataSource(dsc);

        /**
         *  策略配置
         */
        StrategyConfig strategy = new StrategyConfig();
        //strategy.setTablePrefix(new String[] { "buy_" });// 此处可以修改为您的表前缀
        strategy.setNaming(NamingStrategy.underline_to_camel);// 表名生成策略
        // 需要生成的表 不设置则生成所有表
        //strategy.setInclude(new String[] { "staff","role"});
        strategy.setEntityLombokModel(true); // 是否为lombok模型
        strategy.setEntityBooleanColumnRemoveIsPrefix(true); // Boolean类型字段是否移除is前缀
        mpg.setStrategy(strategy);

        /**
         * 包配置
          */
        PackageConfig pc = new PackageConfig();
        pc.setParent("com.hfut.laboratory");
        pc.setEntity("pojo");
        mpg.setPackageInfo(pc);

        /**
         * 自定义配置（把mapper.xml生成到resources目录下）
          */
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                // to do nothing
            }
        };

        // 如果模板引擎是 velocity
        //String templatePath = "/templates/mapper.xml.vm";
        // 如果模板引擎是 freemarker
        String templatePath = "/templates/mapper.xml.ftl";

        // 自定义输出配置（把mapper.xml生成到resources目录下）
        List<FileOutConfig> focList = new ArrayList<>();
        // 自定义配置会被优先输出
        focList.add(new FileOutConfig(templatePath) {
            @Override
            public String outputFile(TableInfo tableInfo) {
                // 自定义输出文件名
                return "C:\\EXCS\\IDEA_exc\\accout-mange\\src\\main\\resources\\mappers\\"
                        + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
            }
        });
        cfg.setFileOutConfigList(focList);
        mpg.setCfg(cfg);

        /**
         * 关闭默认 xml 生成
         */
        mpg.setTemplate(
                // 关闭默认 xml 生成，调整生成 至 根目录
                new TemplateConfig().setXml(null)
        );


        // 执行生成
        mpg.execute();
    }

}

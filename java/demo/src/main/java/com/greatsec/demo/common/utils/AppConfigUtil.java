package com.greatsec.demo.common.utils;

import java.util.Properties;

public class AppConfigUtil
{
  public static String get(String propertyKey)
  {
    Properties properties = (Properties)SpringContextHolder.getBean("configproperties");
    return properties.getProperty(propertyKey);
  }
}
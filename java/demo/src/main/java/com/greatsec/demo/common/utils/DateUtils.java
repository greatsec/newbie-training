package com.greatsec.demo.common.utils;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;

/**
 * 日期工具类, 继承org.apache.commons.lang.time.DateUtils类
 * @author bmwm.cn
 * @version 2013-3-15
 */
public class DateUtils extends org.apache.commons.lang.time.DateUtils
{
    
    private static String[] parsePatterns = {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy/MM/dd",
        "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm"};
    
    /**
     * 得到当前日期字符串 格式（yyyy-MM-dd）
     */
    public static String getDate()
    {
        return getDate("yyyy-MM-dd");
    }
    
    /**
     * 得到当前日期字符串 格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
     */
    public static String getDate(String pattern)
    {
        return DateFormatUtils.format(new Date(), pattern);
    }
    
    /**
     * 得到日期字符串 默认格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
     */
    public static String formatDate(Date date, Object... pattern)
    {
        String formatDate = null;
        if (pattern != null && pattern.length > 0)
        {
            formatDate = DateFormatUtils.format(date, pattern[0].toString());
        }
        else
        {
            formatDate = DateFormatUtils.format(date, "yyyy-MM-dd");
        }
        return formatDate;
    }
    
    /**
     * 得到当前时间字符串 格式（HH:mm:ss）
     */
    public static String getTime()
    {
        return formatDate(new Date(), "HH:mm:ss");
    }
    
    /**
     * 得到当前日期和时间字符串 格式（yyyy-MM-dd HH:mm:ss）
     */
    public static String getDateTime()
    {
        return formatDate(new Date(), "yyyy-MM-dd HH:mm:ss");
    }
    
    /**
     * 得到当前年份字符串 格式（yyyy）
     */
    public static String getYear()
    {
        return formatDate(new Date(), "yyyy");
    }
    
    /**
     * 得到当前月份字符串 格式（MM）
     */
    public static String getMonth()
    {
        return formatDate(new Date(), "MM");
    }
    
    /**
     * 得到当天字符串 格式（dd）
     */
    public static String getDay()
    {
        return formatDate(new Date(), "dd");
    }
    
    /**
     * 得到当前星期字符串 格式（E）星期几
     */
    public static String getWeek()
    {
        return formatDate(new Date(), "E");
    }
    
    /**
     * 日期型字符串转化为日期 格式
     * { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", 
     *   "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" }
     */
    public static Date parseDate(Object str)
    {
        if (str == null)
        {
            return null;
        }
        try
        {
            return parseDate(str.toString(), parsePatterns);
        }
        catch (ParseException e)
        {
            return null;
        }
    }
    
    /**
     * 获取过去的天数
     * @param date
     * @return
     */
    public static long pastDays(Date date)
    {
        long t = new Date().getTime() - date.getTime();
        return t / (24 * 60 * 60 * 1000);
    }
    
    public static String getTime(Long millseconds)
    {
        String time = "";
        if (millseconds == null)
        {
            return "";
        }
        int days = (int)millseconds.longValue() / 1000 / 60 / 60 / 24;
        if (days > 0)
        {
            time = time + days + "天";
        }
        long hourMillseconds = millseconds.longValue() - days * 1000 * 60 * 60 * 24;
        int hours = (int)hourMillseconds / 1000 / 60 / 60;
        if (hours > 0)
        {
            time = time + hours + "小时";
        }
        long minuteMillseconds = millseconds.longValue() - days * 1000 * 60 * 60 * 24 - hours * 1000 * 60 * 60;
        int minutes = (int)minuteMillseconds / 1000 / 60;
        if (minutes > 0)
        {
            time = time + minutes + "分钟";
        }
        else
        {
            int seconds = (int)minuteMillseconds / 1000;
            if (seconds > 0)
            {
                time = seconds + "秒";
            }
        }
        
        return time;
    }
    
    public static String getAge(Date birthDay)
    {
        Calendar cal = Calendar.getInstance();
        if (cal.before(birthDay))
        {
            return "年龄错误";
        }
        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH) + 1;
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
        cal.setTime(birthDay);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
        int age = yearNow - yearBirth;
        if (monthNow <= monthBirth)
        {
            if (monthNow == monthBirth)
            {
                //monthNow==monthBirth 
                if (dayOfMonthNow < dayOfMonthBirth)
                {
                    age--;
                }
            }
            else
            {
                //monthNow>monthBirth 
                age--;
            }
        }
        return age + "";
    }
    
    /**
     * @param args
     * @throws ParseException
     */
    public static void main(String[] args)
        throws ParseException
    {
        //		System.out.println(formatDate(parseDate("2010/3/6")));
        //		System.out.println(getDate("yyyy年MM月dd日 E"));
        //		long time = new Date().getTime()-parseDate("2012-11-19").getTime();
        //		System.out.println(time/(24*60*60*1000));
    }
    
    /**
     * <p>将日期转换为当天的开始时间。即时分秒设置为00:00:00</p>
     * @param date 日期对象
     * @return 当天的开始时间
    */
    public static Date toStartDate(Date date)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }
    
    /**
      * <p>将日期转换为当天的结束时间。即时分秒设置为23:59:59</p>
      * @param date 日期对象
      * @return 当天的结束时间
     */
    public static Date toEndDate(Date date)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        return calendar.getTime();
    }
}

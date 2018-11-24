<?php

/**
 * 时间使用区间有效判定
 *
 * @author Ztj
 * @param array $used_times 已使用时间区间, start_time=>end_time
 * @param int $start_time 开始时间
 * @param int $end_time 结束时间
 * @return bool
 */
function time_use_region_judge($used_times, $start_time, $end_time)
{
    //升序排序
    $used_start_times = array_keys($used_times);
    sort($used_start_times);
    //循环并判定时间段
    reset($used_start_times);
    while ($used_start_time = current($used_start_times)) {
        //当 已使用开始时间 大于 开始时间
        if ($used_start_time > $start_time) {
            //最大结束时间
            $max_end_time = $used_start_time;
            //是否存在上一个时间段
            if ($prev_used_start_time = prev($used_start_times)) {
                //存在上一个时间段，最小开始时间为 上一个 已使用结束时间
                $min_start_time = $used_times[$prev_used_start_time];
                //时间判断定
                if ($start_time >= $min_start_time && $max_end_time >= $end_time) {
                    return true;
                } else {
                    return false;
                }
            } else {
                //不存在上一个时间段，判定 最大结束时间 大于 结束时间
                if ($max_end_time >= $end_time) {
                    return true;
                } else {
                    return false;
                }
            }
        }
        //最后一次循环处理
        if (!next($used_start_times)) {
            //获取 上一次 已使用时间
            $prev_used_start_time = end($used_start_times);
            //获取 最小开始时间
            $min_start_time = $used_times[$prev_used_start_time];
            //开始时间 大于 最小开始时间
            if ($start_time >= $min_start_time) {
                return true;
            } else {
                return false;
            }
        }
    }
    return true;
}

class Test extends PHPUnit_Framework_TestCase
{
    public function test_time_use_region_judge()
    {
        $used_times = [
            5 => 10,
            15 => 20,
            23 => 25
        ];
        $this->assertTrue(time_use_region_judge($used_times, 1, 5));
        $this->assertTrue(time_use_region_judge($used_times, 25, 30));
        $this->assertTrue(time_use_region_judge($used_times, 12, 13));
        $this->assertTrue(time_use_region_judge($used_times, 10, 15));
        $this->assertFalse(time_use_region_judge($used_times, 20, 25));
        $this->assertFalse(time_use_region_judge($used_times, 1, 6));
        $this->assertFalse(time_use_region_judge($used_times, 24, 30));
        $this->assertFalse(time_use_region_judge($used_times, 5, 10));
        $this->assertFalse(time_use_region_judge($used_times, 8, 21));
    }
}

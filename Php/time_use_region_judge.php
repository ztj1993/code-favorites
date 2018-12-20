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
    //如果存在相同的开始时间，直接返回 false
    if (isset($used_times[$start_time])) return false;
    //获取所有的开始时间
    $start_times = array_keys($used_times);
    //将开始时间加入开始时间中
    array_push($start_times, $start_time);
    //升序排序时间
    sort($start_times);
    //获取当前选择时间位置
    $index = array_search($start_time, $start_times);
    //判断开始时间
    if ($index > 0 && $used_times[$start_times[$index - 1]] > $start_time) {
        return false;
    }
    //判断结束时间
    if (isset($start_times[$index + 1]) && $start_times[$index + 1] < $end_time) {
        return false;
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

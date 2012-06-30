#!/system/bin/sh


target=`getprop ro.board.platform`
case "$target" in
    "msm7201a_ffa" | "msm7201a_surf" | "msm7627_ffa" | "msm7627_surf" | "msm7627a" | \
    "qsd8250_surf" | "qsd8250_ffa" | "msm7630_surf" | "msm7630_1x" | "msm7630_fusion" | "qsd8650a_st1x")
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        ;;
esac

case "$target" in
    "msm8960")
     echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
     echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
     echo 93 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
     echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
     echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
     echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
     echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
     echo 192000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
     echo 192000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
     chown system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
     chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
     chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
     chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
     chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
     chown root.system /sys/devices/system/cpu/mfreq
     chmod 220 /sys/devices/system/cpu/mfreq
     chown root.system /sys/devices/system/cpu/cpu1/online
     chmod 664 /sys/devices/system/cpu/cpu1/online
     chown system /sys/power/perflock
     chown system /sys/power/cpufreq_ceiling
     chown system /sys/module/restart/parameters/notify_efs_sync
     echo "0,4,6,8,14,15" > /sys/module/lowmemorykiller/parameters/adj
     echo "2560,4096,6144,7680,8704,10240" > /sys/module/lowmemorykiller/parameters/minfree
        ;;
esac

chown system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate

emmc_boot=`getprop ro.emmc`
case "$emmc_boot"
    in "1")
        chown system /sys/devices/platform/rs300000a7.65536/force_sync
        chown system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown system /sys/devices/platform/rs300100a7.65536/force_sync
        chown system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac


# Post-setup services
case "$target" in
    "msm8660" | "msm8960")
        start mpdecision
    ;;
esac

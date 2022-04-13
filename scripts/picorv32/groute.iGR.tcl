{
    "GR": {
        "db_tool": "iDB",
        "output_dir_path": "/home/zengzhisheng/iFlow/result/aes_cipher_top.groute.openroad_1.2.0.HS.TYP.1.0",
        "DBWrapper": {
            "tech_lef_path": "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_fd_sc_hs.tlef",
            "lef_paths": [
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__com_bus_slice_1um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__com_bus_slice_5um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__com_bus_slice_10um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__com_bus_slice_20um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__corner_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__disconnect_vccd_slice_5um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__disconnect_vdda_slice_5um.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__gpiov2_pad_wrapped.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vccd_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vccd_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vdda_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vdda_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vddio_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vddio_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssa_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssa_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssd_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssd_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssio_hvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_ef_io__vssio_lvc_pad.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_fd_io__top_xres4v2.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_fd_sc_hs_merged.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_sram_1rw1r_44x64_8.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_sram_1rw1r_64x256_8.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_sram_1rw1r_80x64_8.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130_sram_1rw1r_128x256_8.lef",
                "/home/zengzhisheng/iFlow/foundry/sky130/lef/sky130io_fill.lef"
            ],
            "def_path": "/home/zengzhisheng/iFlow/result/aes_cipher_top.filler.openroad_1.1.0.HS.TYP.1.0/aes_cipher_top.def",
            "net_filter": []
        },
        "GridManager": {
            "global_utilization_ratio": 1,
            "layer_utilization_ratio": {}
        },
        "ResourceAllocator": {
            "number_of_frame_levels": 1,
            "initial_penalty_para": 100,
            "penalty_para_drop_rate": 0.8,
            "max_outer_iter_num": 10,
            "max_inner_iter_num": 50
        },
        "PlaneRouter": {
            "single_enlarge_range": 10,
            "max_enlarge_times": 10,
            "max_lut_capicity": 99999,
            "resource_weight": 3,
            "congestion_weight": 1
        },
        "LayerAssigner": {
            "max_segment_length": 1,
            "via_weight": 1,
            "congestion_weight": 1
        }
    }
}
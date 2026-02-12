address([(0xaa45a54c,'lottery')]).

% lottery_yul_v1_p4.sol:Lottery contract
:- dynamic at/3.
:- discontiguous at/3.
:- discontiguous nextlab/3.
:- discontiguous globals/2.
:- discontiguous signatures/2.
:- discontiguous memory/2.
:- discontiguous fun/5.

signatures('lottery_0xaa45a54c', [('external_fun_pickWinner_72', '0x5d495aea00000000000000000000000000000000000000000000000000000000'), ('external_fun_enter_59', '0xe97dcb6200000000000000000000000000000000000000000000000000000000')]).

globals('lottery_0xaa45a54c', [(address, 0xaa45a54c), 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33]).
memory('lottery_0xaa45a54c', [0x00, 0x04, 0x40, 0x80, 0x128, 0xa0, 0xc0, 0xe0]).

fun('lottery_0xaa45a54c', obj_abi_decode_t_uint256_fromMemory, [var(v0), var(v1)], [var(v3)], 'obj_abi_decode_t_uint256_fromMemory_Block0_1').
fun('lottery_0xaa45a54c', obj_abi_decode_tuple_t_uint256_fromMemory, [var(v0), var(v1)], [var(v5), var(v12), var(v11), var(v4)], 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_1').
fun('lottery_0xaa45a54c', obj_allocate_memory, [var(v0)], [var(v2)], 'obj_allocate_memory_Block0_1').
fun('lottery_0xaa45a54c', obj_allocate_unbounded, [], [var(v2)], 'obj_allocate_unbounded_Block0_1').
fun('lottery_0xaa45a54c', obj_cleanup_t_uint256, [var(v0)], [], 'obj_cleanup_t_uint256_ret').
fun('lottery_0xaa45a54c', obj_constructor_Lottery_80, [var(v0)], [var(v1)], 'obj_constructor_Lottery_80_Block0_1').
fun('lottery_0xaa45a54c', obj_convert_t_uint256_to_t_uint256, [var(v0)], [var(v2), var(v3), var(v4)], 'obj_convert_t_uint256_to_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', obj_copy_arguments_for_constructor_28_object_Lottery_80, [], [var(v4), var(v1), var(v3), var(v5), var(v2), var(v6)], 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_1').
fun('lottery_0xaa45a54c', obj_finalize_allocation, [var(v0), var(v1)], [var(v4), var(v3), var(v2), var(v6), var(v7)], 'obj_finalize_allocation_Block0_1').
fun('lottery_0xaa45a54c', obj_identity, [var(v0)], [], 'obj_identity_ret').
fun('lottery_0xaa45a54c', obj_panic_error_0x41, [], [], 'obj_panic_error_0x41_Block0_1').
fun('lottery_0xaa45a54c', obj_prepare_store_t_uint256, [var(v0)], [], 'obj_prepare_store_t_uint256_ret').
fun('lottery_0xaa45a54c', obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db, [], [], 'obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1').
fun('lottery_0xaa45a54c', obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('lottery_0xaa45a54c', obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('lottery_0xaa45a54c', obj_round_up_to_mul_of_32, [var(v0)], [var(v5), var(v3), var(v4)], 'obj_round_up_to_mul_of_32_Block0_1').
fun('lottery_0xaa45a54c', obj_shift_left_0, [var(v0)], [var(v2)], 'obj_shift_left_0_Block0_1').
fun('lottery_0xaa45a54c', obj_update_byte_slice_32_shift_0, [var(v0), var(v1)], [var(v4), var(v5), var(v8), var(v6), var(v7)], 'obj_update_byte_slice_32_shift_0_Block0_1').
fun('lottery_0xaa45a54c', obj_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v0), var(v1)], [var(v2), var(v5), var(v3), var(v4)], 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', obj_validator_revert_t_uint256, [var(v0)], [var(v2), var(v1), var(v3)], 'obj_validator_revert_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_abi_decode_tuple_, [var(v0), var(v1)], [var(v3), var(v4)], 'subO_abi_decode_tuple__Block0_1').
fun('lottery_0xaa45a54c', subO_abi_encode_tuple__to__fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple__to__fromStack_Block0_1').
fun('lottery_0xaa45a54c', subO_allocate_unbounded, [], [var(v2)], 'subO_allocate_unbounded_Block0_1').
fun('lottery_0xaa45a54c', 'subO_array_dataslot_t_array$_t_address_$300_storage', [var(v0)], [], 'subO_array_dataslot_t_array$_t_address_$300_storage_ret').
fun('lottery_0xaa45a54c', subO_array_dataslot_t_bytes_storage_ptr, [var(v0)], [var(v3)], 'subO_array_dataslot_t_bytes_storage_ptr_Block0_1').
fun('lottery_0xaa45a54c', 'subO_array_length_t_array$_t_address_$300_storage', [var(v0)], [], 'subO_array_length_t_array$_t_address_$300_storage_ret').
fun('lottery_0xaa45a54c', subO_assert_helper, [var(v0)], [var(v1)], 'subO_assert_helper_Block0_1').
fun('lottery_0xaa45a54c', subO_checked_sub_t_uint256, [var(v0), var(v1)], [var(v5), var(v3), var(v6), var(v4)], 'subO_checked_sub_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_cleanup_from_storage_t_address, [var(v0)], [var(v3)], 'subO_cleanup_from_storage_t_address_Block0_1').
fun('lottery_0xaa45a54c', subO_cleanup_from_storage_t_uint256, [var(v0)], [], 'subO_cleanup_from_storage_t_uint256_ret').
fun('lottery_0xaa45a54c', subO_cleanup_t_address, [var(v0)], [var(v2)], 'subO_cleanup_t_address_Block0_1').
fun('lottery_0xaa45a54c', subO_cleanup_t_rational_0_by_1, [var(v0)], [], 'subO_cleanup_t_rational_0_by_1_ret').
fun('lottery_0xaa45a54c', subO_cleanup_t_rational_1_by_1, [var(v0)], [], 'subO_cleanup_t_rational_1_by_1_ret').
fun('lottery_0xaa45a54c', subO_cleanup_t_uint160, [var(v0)], [var(v3)], 'subO_cleanup_t_uint160_Block0_1').
fun('lottery_0xaa45a54c', subO_cleanup_t_uint256, [var(v0)], [], 'subO_cleanup_t_uint256_ret').
fun('lottery_0xaa45a54c', subO_convert_t_rational_0_by_1_to_t_uint256, [var(v0)], [var(v2), var(v3), var(v4)], 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_convert_t_rational_1_by_1_to_t_uint256, [var(v0)], [var(v2), var(v3), var(v4)], 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_external_fun_enter_59, [], [var(v2), var(v3), var(v0), var(v4)], 'subO_external_fun_enter_59_Block0_1').
fun('lottery_0xaa45a54c', subO_external_fun_pickWinner_72, [], [var(v0), var(v4), var(v1), var(v3), var(v5)], 'subO_external_fun_pickWinner_72_Block0_1').
fun('lottery_0xaa45a54c', subO_extract_from_storage_value_dynamict_address, [var(v0), var(v1)], [var(v5), var(v6), var(v4)], 'subO_extract_from_storage_value_dynamict_address_Block0_1').
fun('lottery_0xaa45a54c', subO_extract_from_storage_value_offset_0_t_uint256, [var(v0)], [var(v2), var(v3)], 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_fun_enter_59, [], [var(v17), var(v4), var(v32), var(v28), var(v5), var(v31), var(v7), var(v24), var(v33), var(v13), var(v23), var(v14), var(v22), var(v16), var(v9), var(v25), var(v43), var(v41), var(v27), var(v36), var(v1), var(v38), var(v37), var(v11), var(v42), var(v44), var(v29), var(v3), var(v12), var(v40), var(v26), var(v30), var(v10), var(v39)], 'subO_fun_enter_59_Block0_1').
fun('lottery_0xaa45a54c', subO_fun_pickWinner_72, [], [var(v17), var(v4), var(v28), var(v5), var(v31), var(v24), var(v13), var(v14), var(v22), var(v16), var(v9), var(v8), var(v21), var(v35), var(v27), var(v36), var(v1), var(v37), var(v15), var(v11), var(v29), var(v3), var(v12), var(v19), var(v26), var(v20), var(v30), var(v10), var(v6)], 'subO_fun_pickWinner_72_Block0_1').
fun('lottery_0xaa45a54c', subO_fun_random_79, [], [var(v6), var(v1), var(v3), var(v4)], 'subO_fun_random_79_Block0_1').
fun('lottery_0xaa45a54c', subO_identity, [var(v0)], [], 'subO_identity_ret').
fun('lottery_0xaa45a54c', subO_increment_wrapping_t_uint256, [var(v0)], [var(v3), var(v4)], 'subO_increment_wrapping_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_long_byte_array_index_access_no_checks, [var(v0), var(v1)], [var(v4), var(v9), var(v8), var(v6), var(v7)], 'subO_long_byte_array_index_access_no_checks_Block0_1').
fun('lottery_0xaa45a54c', subO_mod_t_uint256, [var(v0), var(v1)], [var(v5), var(v3), var(v11), var(v4)], 'subO_mod_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_panic_error_0x01, [], [], 'subO_panic_error_0x01_Block0_1').
fun('lottery_0xaa45a54c', subO_panic_error_0x11, [], [], 'subO_panic_error_0x11_Block0_1').
fun('lottery_0xaa45a54c', subO_panic_error_0x12, [], [], 'subO_panic_error_0x12_Block0_1').
fun('lottery_0xaa45a54c', subO_panic_error_0x32, [], [], 'subO_panic_error_0x32_Block0_1').
fun('lottery_0xaa45a54c', subO_read_from_storage_split_dynamic_t_address, [var(v0), var(v1)], [var(v3), var(v4)], 'subO_read_from_storage_split_dynamic_t_address_Block0_1').
fun('lottery_0xaa45a54c', subO_read_from_storage_split_offset_0_t_uint256, [var(v0)], [var(v2), var(v3)], 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1').
fun('lottery_0xaa45a54c', subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [], 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1').
fun('lottery_0xaa45a54c', subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('lottery_0xaa45a54c', subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('lottery_0xaa45a54c', subO_shift_right_0_unsigned, [var(v0)], [var(v2)], 'subO_shift_right_0_unsigned_Block0_1').
fun('lottery_0xaa45a54c', subO_shift_right_224_unsigned, [var(v0)], [var(v3)], 'subO_shift_right_224_unsigned_Block0_1').
fun('lottery_0xaa45a54c', subO_shift_right_unsigned_dynamic, [var(v0), var(v1)], [var(v3)], 'subO_shift_right_unsigned_dynamic_Block0_1').
fun('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage', [var(v0), var(v1)], [var(v13), var(v4), var(v14), var(v3), var(v5), var(v9)], 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_1').
fun('lottery_0xaa45a54c', subO_zero_value_for_split_t_uint256, [], [], 'subO_zero_value_for_split_t_uint256_ret').
fun('lottery_0xaa45a54c', r_Lottery_80_deployed, [], [var(v4), var(v3), var(v5), var(v9), var(v8), var(v11), var(v7)], 'Lottery_80_deployed_Block0_1').
fun('lottery_0xaa45a54c', init_contract, [], [var(v0), var(v4), var(v3), var(v5), var(v2), var(v6), var(v7)], 'init_contract_Block0_1').

at('lottery_0xaa45a54c', 'obj_abi_decode_t_uint256_fromMemory_Block0_1', asgn(var(v3), expr(mload([var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_t_uint256_fromMemory_Block0_1', 'obj_abi_decode_t_uint256_fromMemory_Block0_2').
at('lottery_0xaa45a54c', 'obj_abi_decode_t_uint256_fromMemory_Block0_2', fun_call(obj_validator_revert_t_uint256, [var(v3)], [])).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_t_uint256_fromMemory_Block0_2', 'obj_abi_decode_t_uint256_fromMemory_ret').
at('lottery_0xaa45a54c', 'obj_abi_decode_t_uint256_fromMemory_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_1', asgn(var(v4), expr(sub([var(v0), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_1', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_2').
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_2', asgn(var(v5), expr(slt([num(0x20), var(v4)])))).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_2', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_3').
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block0_3', cj(var(v5), 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_1', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block1_1')).
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_1', asgn(var(v11), expr(add([num(0x00), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_1', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_2').
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_2', fun_call(obj_abi_decode_t_uint256_fromMemory, [var(v1), var(v11)], [var(v12)])).
nextlab('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block2_2', 'obj_abi_decode_tuple_t_uint256_fromMemory_ret').
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_ret', ret([var(v12)])).
at('lottery_0xaa45a54c', 'obj_abi_decode_tuple_t_uint256_fromMemory_Block1_1', fun_call(obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('lottery_0xaa45a54c', 'obj_allocate_memory_Block0_1', fun_call(obj_allocate_unbounded, [], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'obj_allocate_memory_Block0_1', 'obj_allocate_memory_Block0_2').
at('lottery_0xaa45a54c', 'obj_allocate_memory_Block0_2', fun_call(obj_finalize_allocation, [var(v0), var(v2)], [])).
nextlab('lottery_0xaa45a54c', 'obj_allocate_memory_Block0_2', 'obj_allocate_memory_ret').
at('lottery_0xaa45a54c', 'obj_allocate_memory_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'obj_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('lottery_0xaa45a54c', 'obj_allocate_unbounded_Block0_1', 'obj_allocate_unbounded_ret').
at('lottery_0xaa45a54c', 'obj_allocate_unbounded_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'obj_cleanup_t_uint256_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_1', asgn(var(v1), expr(number))).
nextlab('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_1', 'obj_constructor_Lottery_80_Block0_2').
at('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_2', fun_call(obj_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v1), off(0x01)], [])).
nextlab('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_2', 'obj_constructor_Lottery_80_Block0_3').
at('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_3', fun_call(obj_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v0), off(0x02)], [])).
nextlab('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_Block0_3', 'obj_constructor_Lottery_80_ret').
at('lottery_0xaa45a54c', 'obj_constructor_Lottery_80_ret', ret([])).
at('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_1', fun_call(obj_cleanup_t_uint256, [var(v0)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_1', 'obj_convert_t_uint256_to_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_2', fun_call(obj_identity, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_2', 'obj_convert_t_uint256_to_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_3', fun_call(obj_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_Block0_3', 'obj_convert_t_uint256_to_t_uint256_ret').
at('lottery_0xaa45a54c', 'obj_convert_t_uint256_to_t_uint256_ret', ret([var(v4)])).
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_1', asgn(var(v1), expr(datasize))).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_1', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_2').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_2', asgn(var(v2), expr(codesize))).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_2', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_3').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_3', asgn(var(v3), expr(sub([var(v1), var(v2)])))).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_3', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_4').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_4', fun_call(obj_allocate_memory, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_4', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_5').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_5', codecopy([var(v3), var(v1), var(v4)])).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_5', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_6').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_6', asgn(var(v5), expr(add([var(v3), var(v4)])))).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_6', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_7').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_7', fun_call(obj_abi_decode_tuple_t_uint256_fromMemory, [var(v5), var(v4)], [var(v6)])).
nextlab('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_Block0_7', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_ret').
at('lottery_0xaa45a54c', 'obj_copy_arguments_for_constructor_28_object_Lottery_80_ret', ret([var(v6)])).
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_1', fun_call(obj_round_up_to_mul_of_32, [var(v1)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_1', 'obj_finalize_allocation_Block0_2').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_2', asgn(var(v3), expr(add([var(v2), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_2', 'obj_finalize_allocation_Block0_3').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_3', asgn(var(v4), expr(lt([var(v0), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_3', 'obj_finalize_allocation_Block0_4').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_4', asgn(var(v6), expr(gt([num(0xffffffffffffffff), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_4', 'obj_finalize_allocation_Block0_5').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_5', asgn(var(v7), expr(or([var(v4), var(v6)])))).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_5', 'obj_finalize_allocation_Block0_6').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block0_6', cj(var(v7), 'obj_finalize_allocation_Block2_1', 'obj_finalize_allocation_Block1_1')).
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block2_1', mstore([var(v3), mem(0x40)])).
nextlab('lottery_0xaa45a54c', 'obj_finalize_allocation_Block2_1', 'obj_finalize_allocation_ret').
at('lottery_0xaa45a54c', 'obj_finalize_allocation_ret', ret([])).
at('lottery_0xaa45a54c', 'obj_finalize_allocation_Block1_1', fun_call(obj_panic_error_0x41, [], [])).
at('lottery_0xaa45a54c', 'obj_identity_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'obj_panic_error_0x41_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'obj_panic_error_0x41_Block0_1', 'obj_panic_error_0x41_Block0_2').
at('lottery_0xaa45a54c', 'obj_panic_error_0x41_Block0_2', mstore([num(0x41), mem(0x04)])).
nextlab('lottery_0xaa45a54c', 'obj_panic_error_0x41_Block0_2', 'obj_panic_error_0x41_Block0_3').
at('lottery_0xaa45a54c', 'obj_panic_error_0x41_Block0_3', revert([num(0x24), mem(0x00)])).
at('lottery_0xaa45a54c', 'obj_prepare_store_t_uint256_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_1', asgn(var(v3), expr(not([num(0x1f)])))).
nextlab('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_1', 'obj_round_up_to_mul_of_32_Block0_2').
at('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_2', asgn(var(v4), expr(add([num(0x1f), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_2', 'obj_round_up_to_mul_of_32_Block0_3').
at('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_3', asgn(var(v5), expr(and([var(v3), var(v4)])))).
nextlab('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_Block0_3', 'obj_round_up_to_mul_of_32_ret').
at('lottery_0xaa45a54c', 'obj_round_up_to_mul_of_32_ret', ret([var(v5)])).
at('lottery_0xaa45a54c', 'obj_shift_left_0_Block0_1', asgn(var(v2), expr(shl([var(v0), num(0x00)])))).
nextlab('lottery_0xaa45a54c', 'obj_shift_left_0_Block0_1', 'obj_shift_left_0_ret').
at('lottery_0xaa45a54c', 'obj_shift_left_0_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_1', fun_call(obj_shift_left_0, [var(v1)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_1', 'obj_update_byte_slice_32_shift_0_Block0_2').
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_2', asgn(var(v5), expr(not([num(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)])))).
nextlab('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_2', 'obj_update_byte_slice_32_shift_0_Block0_3').
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_3', asgn(var(v6), expr(and([var(v5), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_3', 'obj_update_byte_slice_32_shift_0_Block0_4').
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_4', asgn(var(v7), expr(and([num(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), var(v4)])))).
nextlab('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_4', 'obj_update_byte_slice_32_shift_0_Block0_5').
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_5', asgn(var(v8), expr(or([var(v7), var(v6)])))).
nextlab('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_Block0_5', 'obj_update_byte_slice_32_shift_0_ret').
at('lottery_0xaa45a54c', 'obj_update_byte_slice_32_shift_0_ret', ret([var(v8)])).
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1', fun_call(obj_convert_t_uint256_to_t_uint256, [var(v1)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2', fun_call(obj_prepare_store_t_uint256, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3', asgn(var(v4), expr(sload([var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4').
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4', fun_call(obj_update_byte_slice_32_shift_0, [var(v3), var(v4)], [var(v5)])).
nextlab('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5').
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5', sstore([var(v5), var(v0)])).
nextlab('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_ret').
at('lottery_0xaa45a54c', 'obj_update_storage_value_offset_0_t_uint256_to_t_uint256_ret', ret([])).
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_1', fun_call(obj_cleanup_t_uint256, [var(v0)], [var(v1)])).
nextlab('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_1', 'obj_validator_revert_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_2', 'obj_validator_revert_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_3', 'obj_validator_revert_t_uint256_Block0_4').
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block0_4', cj(var(v3), 'obj_validator_revert_t_uint256_ret', 'obj_validator_revert_t_uint256_Block1_1')).
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_ret', ret([])).
at('lottery_0xaa45a54c', 'obj_validator_revert_t_uint256_Block1_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block0_1', asgn(var(v3), expr(sub([var(v0), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block0_1', 'subO_abi_decode_tuple__Block0_2').
at('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block0_2', asgn(var(v4), expr(slt([num(0x00), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block0_2', 'subO_abi_decode_tuple__Block0_3').
at('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block0_3', cj(var(v4), 'subO_abi_decode_tuple__ret', 'subO_abi_decode_tuple__Block1_1')).
at('lottery_0xaa45a54c', 'subO_abi_decode_tuple__ret', ret([])).
at('lottery_0xaa45a54c', 'subO_abi_decode_tuple__Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('lottery_0xaa45a54c', 'subO_abi_encode_tuple__to__fromStack_Block0_1', asgn(var(v2), expr(add([num(0x00), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_abi_encode_tuple__to__fromStack_Block0_1', 'subO_abi_encode_tuple__to__fromStack_ret').
at('lottery_0xaa45a54c', 'subO_abi_encode_tuple__to__fromStack_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'subO_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('lottery_0xaa45a54c', 'subO_allocate_unbounded_Block0_1', 'subO_allocate_unbounded_ret').
at('lottery_0xaa45a54c', 'subO_allocate_unbounded_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'subO_array_dataslot_t_array$_t_address_$300_storage_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_array_dataslot_t_bytes_storage_ptr_Block0_1', mstore([var(v0), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_array_dataslot_t_bytes_storage_ptr_Block0_1', 'subO_array_dataslot_t_bytes_storage_ptr_Block0_2').
at('lottery_0xaa45a54c', 'subO_array_dataslot_t_bytes_storage_ptr_Block0_2', keccak256([num(0x20), num(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_array_dataslot_t_bytes_storage_ptr_Block0_2', 'subO_array_dataslot_t_bytes_storage_ptr_ret').
at('lottery_0xaa45a54c', 'subO_array_dataslot_t_bytes_storage_ptr_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_array_length_t_array$_t_address_$300_storage_ret', ret([num(0x012c)])).
at('lottery_0xaa45a54c', 'subO_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_assert_helper_Block0_1', 'subO_assert_helper_Block0_2').
at('lottery_0xaa45a54c', 'subO_assert_helper_Block0_2', cj(var(v1), 'subO_assert_helper_ret', 'subO_assert_helper_Block1_1')).
at('lottery_0xaa45a54c', 'subO_assert_helper_ret', ret([])).
at('lottery_0xaa45a54c', 'subO_assert_helper_Block1_1', fun_call(subO_panic_error_0x01, [], [])).
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_1', 'subO_checked_sub_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_2', fun_call(subO_cleanup_t_uint256, [var(v1)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_2', 'subO_checked_sub_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_3', asgn(var(v5), expr(sub([var(v4), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_3', 'subO_checked_sub_t_uint256_Block0_4').
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_4', asgn(var(v6), expr(gt([var(v3), var(v5)])))).
nextlab('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_4', 'subO_checked_sub_t_uint256_Block0_5').
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block0_5', cj(var(v6), 'subO_checked_sub_t_uint256_ret', 'subO_checked_sub_t_uint256_Block1_1')).
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_ret', ret([var(v5)])).
at('lottery_0xaa45a54c', 'subO_checked_sub_t_uint256_Block1_1', fun_call(subO_panic_error_0x11, [], [])).
at('lottery_0xaa45a54c', 'subO_cleanup_from_storage_t_address_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_cleanup_from_storage_t_address_Block0_1', 'subO_cleanup_from_storage_t_address_ret').
at('lottery_0xaa45a54c', 'subO_cleanup_from_storage_t_address_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_cleanup_from_storage_t_uint256_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_cleanup_t_address_Block0_1', fun_call(subO_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'subO_cleanup_t_address_Block0_1', 'subO_cleanup_t_address_ret').
at('lottery_0xaa45a54c', 'subO_cleanup_t_address_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'subO_cleanup_t_rational_0_by_1_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_cleanup_t_rational_1_by_1_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_cleanup_t_uint160_Block0_1', 'subO_cleanup_t_uint160_ret').
at('lottery_0xaa45a54c', 'subO_cleanup_t_uint160_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_cleanup_t_uint256_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1', fun_call(subO_cleanup_t_rational_0_by_1, [var(v0)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3', 'subO_convert_t_rational_0_by_1_to_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_0_by_1_to_t_uint256_ret', ret([var(v4)])).
at('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_1', fun_call(subO_cleanup_t_rational_1_by_1, [var(v0)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_1', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_2', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_Block0_3', 'subO_convert_t_rational_1_by_1_to_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_convert_t_rational_1_by_1_to_t_uint256_ret', ret([var(v4)])).
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_1', 'subO_external_fun_enter_59_Block0_2').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_2', fun_call(subO_abi_decode_tuple_, [var(v0), num(0x04)], [])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_2', 'subO_external_fun_enter_59_Block0_3').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_3', fun_call(subO_fun_enter_59, [], [])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_3', 'subO_external_fun_enter_59_Block0_4').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_4', 'subO_external_fun_enter_59_Block0_5').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_5', 'subO_external_fun_enter_59_Block0_6').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_6', asgn(var(v4), expr(sub([var(v2), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_6', 'subO_external_fun_enter_59_Block0_7').
at('lottery_0xaa45a54c', 'subO_external_fun_enter_59_Block0_7', return([var(v4), var(v2)])).
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block0_1', 'subO_external_fun_pickWinner_72_Block0_2').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block0_2', cj(var(v0), 'subO_external_fun_pickWinner_72_Block2_1', 'subO_external_fun_pickWinner_72_Block1_1')).
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_1', 'subO_external_fun_pickWinner_72_Block2_2').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_2', fun_call(subO_abi_decode_tuple_, [var(v1), num(0x04)], [])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_2', 'subO_external_fun_pickWinner_72_Block2_3').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_3', fun_call(subO_fun_pickWinner_72, [], [])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_3', 'subO_external_fun_pickWinner_72_Block2_4').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_4', 'subO_external_fun_pickWinner_72_Block2_5').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_5', 'subO_external_fun_pickWinner_72_Block2_6').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_6', asgn(var(v5), expr(sub([var(v3), var(v4)])))).
nextlab('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_6', 'subO_external_fun_pickWinner_72_Block2_7').
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block2_7', return([var(v5), var(v3)])).
at('lottery_0xaa45a54c', 'subO_external_fun_pickWinner_72_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_1', asgn(var(v4), expr(mul([num(0x08), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_1', 'subO_extract_from_storage_value_dynamict_address_Block0_2').
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_2', fun_call(subO_shift_right_unsigned_dynamic, [var(v0), var(v4)], [var(v5)])).
nextlab('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_2', 'subO_extract_from_storage_value_dynamict_address_Block0_3').
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_3', fun_call(subO_cleanup_from_storage_t_address, [var(v5)], [var(v6)])).
nextlab('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_Block0_3', 'subO_extract_from_storage_value_dynamict_address_ret').
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_dynamict_address_ret', ret([var(v6)])).
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', fun_call(subO_shift_right_0_unsigned, [var(v0)], [var(v2)])).
nextlab('lottery_0xaa45a54c', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', fun_call(subO_cleanup_from_storage_t_uint256, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', 'subO_extract_from_storage_value_offset_0_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_extract_from_storage_value_offset_0_t_uint256_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_1', fun_call(subO_zero_value_for_split_t_uint256, [], [var(v1)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_1', 'subO_fun_enter_59_Block0_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_2', asgn(var(v3), expr(callvalue))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_2', 'subO_fun_enter_59_Block0_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_3', asgn(var(v4), expr(eq([num(0x2386f26fc10000), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_3', 'subO_fun_enter_59_Block0_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_4', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_4', 'subO_fun_enter_59_Block0_5').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block0_5', cj(var(v5), 'subO_fun_enter_59_Block2_1', 'subO_fun_enter_59_Block1_1')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_1', asgn(var(v7), expr(sload([off(0x01)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_1', 'subO_fun_enter_59_Block2_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_2', asgn(var(v9), expr(sload([off(0x02)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_2', 'subO_fun_enter_59_Block2_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_3', asgn(var(v10), expr(add([var(v9), var(v7)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_3', 'subO_fun_enter_59_Block2_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_4', asgn(var(v11), expr(number))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_4', 'subO_fun_enter_59_Block2_5').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_5', asgn(var(v12), expr(lt([var(v10), var(v11)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_5', 'subO_fun_enter_59_Block2_6').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_6', asgn(var(v13), expr(iszero([var(v12)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_6', 'subO_fun_enter_59_Block2_7').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block2_7', cj(var(v13), 'subO_fun_enter_59_Block5_1', 'subO_fun_enter_59_Block4_1')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block1_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_1', asgn(var(v14), expr(sload([off(0x00)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_1', 'subO_fun_enter_59_Block5_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_2', asgn(var(v16), expr(lt([num(0x012c), var(v14)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_2', 'subO_fun_enter_59_Block5_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_3', asgn(var(v17), expr(iszero([var(v16)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_3', 'subO_fun_enter_59_Block5_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block5_4', cj(var(v17), 'subO_fun_enter_59_Block8_1', 'subO_fun_enter_59_Block7_1')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block4_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_1', asgn(var(v22), expr(add([var(v14), num(0x04)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_1', 'subO_fun_enter_59_Block8_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_2', asgn(var(v23), expr(caller))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_2', 'subO_fun_enter_59_Block8_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_3', sstore([var(v23), var(v22)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_3', 'subO_fun_enter_59_Block8_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_4', asgn(var(v24), expr(add([num(0x01), var(v14)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_4', 'subO_fun_enter_59_Block8_5').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_5', sstore([var(v24), off(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_5', 'subO_fun_enter_59_Block8_6').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_6', fun_call(subO_convert_t_rational_0_by_1_to_t_uint256, [num(0x00)], [var(v25)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_6', 'subO_fun_enter_59_Block8_7').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block8_7', goto('subO_fun_enter_59_Block11_1_7')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block7_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_1_7', asgn(var(v26), expr(phiFunction([var(v25)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_1_7', 'subO_fun_enter_59_Block11_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_1_11', asgn(var(v26), expr(phiFunction([var(v44)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_1_11', 'subO_fun_enter_59_Block11_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_2', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v27)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_2', 'subO_fun_enter_59_Block11_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_3', fun_call(subO_convert_t_rational_1_by_1_to_t_uint256, [num(0x01)], [var(v28)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_3', 'subO_fun_enter_59_Block11_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_4', fun_call(subO_checked_sub_t_uint256, [var(v28), var(v27)], [var(v29)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_4', 'subO_fun_enter_59_Block11_5').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_5', fun_call(subO_cleanup_t_uint256, [var(v29)], [var(v30)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_5', 'subO_fun_enter_59_Block11_6').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_6', fun_call(subO_cleanup_t_uint256, [var(v26)], [var(v31)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_6', 'subO_fun_enter_59_Block11_7').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_7', asgn(var(v32), expr(lt([var(v30), var(v31)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_7', 'subO_fun_enter_59_Block11_8').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_8', asgn(var(v33), expr(iszero([var(v32)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_8', 'subO_fun_enter_59_Block11_9').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block11_9', cj(var(v33), 'subO_fun_enter_59_Block15_1', 'subO_fun_enter_59_Block14_1')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_1', fun_call('subO_storage_array_index_access_t_array$_t_address_$300_storage', [var(v26), num(0x04)], [var(v36), var(v37)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_1', 'subO_fun_enter_59_Block15_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_2', fun_call(subO_read_from_storage_split_dynamic_t_address, [var(v37), var(v36)], [var(v38)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_2', 'subO_fun_enter_59_Block15_3').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_3', asgn(var(v39), expr(caller))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_3', 'subO_fun_enter_59_Block15_4').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_4', fun_call(subO_cleanup_t_address, [var(v39)], [var(v40)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_4', 'subO_fun_enter_59_Block15_5').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_5', fun_call(subO_cleanup_t_address, [var(v38)], [var(v41)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_5', 'subO_fun_enter_59_Block15_6').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_6', asgn(var(v42), expr(eq([var(v40), var(v41)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_6', 'subO_fun_enter_59_Block15_7').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_7', asgn(var(v43), expr(iszero([var(v42)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_7', 'subO_fun_enter_59_Block15_8').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_8', fun_call(subO_assert_helper, [var(v43)], [])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_8', 'subO_fun_enter_59_Block15_9').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block15_9', goto('subO_fun_enter_59_Block12_1')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block14_1', goto('subO_fun_enter_59_ret')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block12_1', fun_call(subO_increment_wrapping_t_uint256, [var(v26)], [var(v44)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_enter_59_Block12_1', 'subO_fun_enter_59_Block12_2').
at('lottery_0xaa45a54c', 'subO_fun_enter_59_Block12_2', goto('subO_fun_enter_59_Block11_1_11')).
at('lottery_0xaa45a54c', 'subO_fun_enter_59_ret', ret([])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_1', asgn(var(v1), expr(sload([off(0x01)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_1', 'subO_fun_pickWinner_72_Block0_2').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_2', asgn(var(v3), expr(sload([off(0x02)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_2', 'subO_fun_pickWinner_72_Block0_3').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_3', asgn(var(v4), expr(add([var(v3), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_3', 'subO_fun_pickWinner_72_Block0_4').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_4', asgn(var(v5), expr(number))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_4', 'subO_fun_pickWinner_72_Block0_5').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_5', asgn(var(v6), expr(lt([var(v4), var(v5)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_5', 'subO_fun_pickWinner_72_Block0_6').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block0_6', cj(var(v6), 'subO_fun_pickWinner_72_Block2_1', 'subO_fun_pickWinner_72_Block1_1')).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_1', asgn(var(v8), expr(address))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_1', 'subO_fun_pickWinner_72_Block2_2').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_2', asgn(var(v9), expr(balance([var(v8)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_2', 'subO_fun_pickWinner_72_Block2_3').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_3', asgn(var(v10), expr(gt([num(0x00), var(v9)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_3', 'subO_fun_pickWinner_72_Block2_4').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_4', asgn(var(v11), expr(iszero([var(v10)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_4', 'subO_fun_pickWinner_72_Block2_5').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block2_5', cj(var(v11), 'subO_fun_pickWinner_72_Block5_1', 'subO_fun_pickWinner_72_Block4_1')).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block1_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_1', asgn(var(v12), expr(sload([off(0x00)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_1', 'subO_fun_pickWinner_72_Block5_2').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_2', asgn(var(v13), expr(gt([num(0x00), var(v12)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_2', 'subO_fun_pickWinner_72_Block5_3').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_3', asgn(var(v14), expr(iszero([var(v13)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_3', 'subO_fun_pickWinner_72_Block5_4').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block5_4', cj(var(v14), 'subO_fun_pickWinner_72_Block8_1', 'subO_fun_pickWinner_72_Block7_1')).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block4_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_1', fun_call(subO_fun_random_79, [], [var(v15)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_1', 'subO_fun_pickWinner_72_Block8_2').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_2', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v16)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_2', 'subO_fun_pickWinner_72_Block8_3').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_3', fun_call(subO_mod_t_uint256, [var(v16), var(v15)], [var(v17)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_3', 'subO_fun_pickWinner_72_Block8_4').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_4', asgn(var(v19), expr(add([var(v17), num(0x04)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_4', 'subO_fun_pickWinner_72_Block8_5').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_5', asgn(var(v20), expr(sload([var(v19)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_5', 'subO_fun_pickWinner_72_Block8_6').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_6', asgn(var(v21), expr(address))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_6', 'subO_fun_pickWinner_72_Block8_7').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_7', asgn(var(v22), expr(balance([var(v21)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_7', 'subO_fun_pickWinner_72_Block8_8').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_8', asgn(var(v24), expr(div([num(0x64), var(v22)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_8', 'subO_fun_pickWinner_72_Block8_9').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_9', sstore([var(v24), off(0x03)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_9', 'subO_fun_pickWinner_72_Block8_10').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_10', asgn(var(v26), expr(caller))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_10', 'subO_fun_pickWinner_72_Block8_11').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_11', asgn(var(v27), expr(gas))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_11', 'subO_fun_pickWinner_72_Block8_12').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_12', call([num(0x00), num(0x00), num(0x00), num(0x00), var(v24), var(v26), var(v27)], var(v28))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_12', 'subO_fun_pickWinner_72_Block8_13').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_13', asgn(var(v29), expr(iszero([var(v28)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_13', 'subO_fun_pickWinner_72_Block8_14').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block8_14', cj(var(v29), 'subO_fun_pickWinner_72_Block11_1', 'subO_fun_pickWinner_72_Block10_1')).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block7_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_1', asgn(var(v30), expr(address))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_1', 'subO_fun_pickWinner_72_Block11_2').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_2', asgn(var(v31), expr(balance([var(v30)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_2', 'subO_fun_pickWinner_72_Block11_3').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_3', asgn(var(v35), expr(gas))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_3', 'subO_fun_pickWinner_72_Block11_4').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_4', call([num(0x00), num(0x00), num(0x00), num(0x00), var(v31), var(v20), var(v35)], var(v36))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_4', 'subO_fun_pickWinner_72_Block11_5').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_5', asgn(var(v37), expr(iszero([var(v36)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_5', 'subO_fun_pickWinner_72_Block11_6').
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block11_6', cj(var(v37), 'subO_fun_pickWinner_72_ret', 'subO_fun_pickWinner_72_Block13_1')).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block10_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_ret', ret([])).
at('lottery_0xaa45a54c', 'subO_fun_pickWinner_72_Block13_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_1', fun_call(subO_zero_value_for_split_t_uint256, [], [var(v1)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_1', 'subO_fun_random_79_Block0_2').
at('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_2', asgn(var(v3), expr(mload([mem(0x40)])))).
nextlab('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_2', 'subO_fun_random_79_Block0_3').
at('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_3', prevrandao([])).
nextlab('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_3', 'subO_fun_random_79_Block0_4').
at('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_4', mstore([var(v4), var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_4', 'subO_fun_random_79_Block0_5').
at('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_5', keccak256([num(0x20), var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_fun_random_79_Block0_5', 'subO_fun_random_79_ret').
at('lottery_0xaa45a54c', 'subO_fun_random_79_ret', ret([var(v6)])).
at('lottery_0xaa45a54c', 'subO_identity_ret', ret([var(v0)])).
at('lottery_0xaa45a54c', 'subO_increment_wrapping_t_uint256_Block0_1', asgn(var(v3), expr(add([num(0x01), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_increment_wrapping_t_uint256_Block0_1', 'subO_increment_wrapping_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_increment_wrapping_t_uint256_Block0_2', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_increment_wrapping_t_uint256_Block0_2', 'subO_increment_wrapping_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_increment_wrapping_t_uint256_ret', ret([var(v4)])).
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_1', asgn(var(v4), expr(mod([num(0x20), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_1', 'subO_long_byte_array_index_access_no_checks_Block0_2').
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_2', asgn(var(v6), expr(sub([var(v4), num(0x1f)])))).
nextlab('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_2', 'subO_long_byte_array_index_access_no_checks_Block0_3').
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_3', fun_call(subO_array_dataslot_t_bytes_storage_ptr, [var(v0)], [var(v7)])).
nextlab('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_3', 'subO_long_byte_array_index_access_no_checks_Block0_4').
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_4', asgn(var(v8), expr(div([num(0x20), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_4', 'subO_long_byte_array_index_access_no_checks_Block0_5').
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_5', asgn(var(v9), expr(add([var(v8), var(v7)])))).
nextlab('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_Block0_5', 'subO_long_byte_array_index_access_no_checks_ret').
at('lottery_0xaa45a54c', 'subO_long_byte_array_index_access_no_checks_ret', ret([var(v9), var(v6)])).
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_1', 'subO_mod_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_2', fun_call(subO_cleanup_t_uint256, [var(v1)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_2', 'subO_mod_t_uint256_Block0_3').
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_3', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_3', 'subO_mod_t_uint256_Block0_4').
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block0_4', cj(var(v5), 'subO_mod_t_uint256_Block2_1', 'subO_mod_t_uint256_Block1_1')).
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block2_1', asgn(var(v11), expr(mod([var(v4), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block2_1', 'subO_mod_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_ret', ret([var(v11)])).
at('lottery_0xaa45a54c', 'subO_mod_t_uint256_Block1_1', fun_call(subO_panic_error_0x12, [], [])).
at('lottery_0xaa45a54c', 'subO_panic_error_0x01_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x01_Block0_1', 'subO_panic_error_0x01_Block0_2').
at('lottery_0xaa45a54c', 'subO_panic_error_0x01_Block0_2', mstore([num(0x01), mem(0x04)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x01_Block0_2', 'subO_panic_error_0x01_Block0_3').
at('lottery_0xaa45a54c', 'subO_panic_error_0x01_Block0_3', revert([num(0x24), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_panic_error_0x11_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x11_Block0_1', 'subO_panic_error_0x11_Block0_2').
at('lottery_0xaa45a54c', 'subO_panic_error_0x11_Block0_2', mstore([num(0x11), mem(0x04)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x11_Block0_2', 'subO_panic_error_0x11_Block0_3').
at('lottery_0xaa45a54c', 'subO_panic_error_0x11_Block0_3', revert([num(0x24), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_panic_error_0x12_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x12_Block0_1', 'subO_panic_error_0x12_Block0_2').
at('lottery_0xaa45a54c', 'subO_panic_error_0x12_Block0_2', mstore([num(0x12), mem(0x04)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x12_Block0_2', 'subO_panic_error_0x12_Block0_3').
at('lottery_0xaa45a54c', 'subO_panic_error_0x12_Block0_3', revert([num(0x24), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_panic_error_0x32_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x32_Block0_1', 'subO_panic_error_0x32_Block0_2').
at('lottery_0xaa45a54c', 'subO_panic_error_0x32_Block0_2', mstore([num(0x32), mem(0x04)])).
nextlab('lottery_0xaa45a54c', 'subO_panic_error_0x32_Block0_2', 'subO_panic_error_0x32_Block0_3').
at('lottery_0xaa45a54c', 'subO_panic_error_0x32_Block0_3', revert([num(0x24), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_dynamic_t_address_Block0_1', asgn(var(v3), expr(sload([var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_read_from_storage_split_dynamic_t_address_Block0_1', 'subO_read_from_storage_split_dynamic_t_address_Block0_2').
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_dynamic_t_address_Block0_2', fun_call(subO_extract_from_storage_value_dynamict_address, [var(v1), var(v3)], [var(v4)])).
nextlab('lottery_0xaa45a54c', 'subO_read_from_storage_split_dynamic_t_address_Block0_2', 'subO_read_from_storage_split_dynamic_t_address_ret').
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_dynamic_t_address_ret', ret([var(v4)])).
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', asgn(var(v2), expr(sload([var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2').
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', fun_call(subO_extract_from_storage_value_offset_0_t_uint256, [var(v2)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', 'subO_read_from_storage_split_offset_0_t_uint256_ret').
at('lottery_0xaa45a54c', 'subO_read_from_storage_split_offset_0_t_uint256_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('lottery_0xaa45a54c', 'subO_shift_right_0_unsigned_Block0_1', asgn(var(v2), expr(shr([var(v0), num(0x00)])))).
nextlab('lottery_0xaa45a54c', 'subO_shift_right_0_unsigned_Block0_1', 'subO_shift_right_0_unsigned_ret').
at('lottery_0xaa45a54c', 'subO_shift_right_0_unsigned_ret', ret([var(v2)])).
at('lottery_0xaa45a54c', 'subO_shift_right_224_unsigned_Block0_1', asgn(var(v3), expr(shr([var(v0), num(0xe0)])))).
nextlab('lottery_0xaa45a54c', 'subO_shift_right_224_unsigned_Block0_1', 'subO_shift_right_224_unsigned_ret').
at('lottery_0xaa45a54c', 'subO_shift_right_224_unsigned_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_shift_right_unsigned_dynamic_Block0_1', asgn(var(v3), expr(shr([var(v1), var(v0)])))).
nextlab('lottery_0xaa45a54c', 'subO_shift_right_unsigned_dynamic_Block0_1', 'subO_shift_right_unsigned_dynamic_ret').
at('lottery_0xaa45a54c', 'subO_shift_right_unsigned_dynamic_ret', ret([var(v3)])).
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_1', fun_call('subO_array_length_t_array$_t_address_$300_storage', [var(v0)], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_1', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_2').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_2', asgn(var(v4), expr(lt([var(v3), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_2', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_3').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_3', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_3', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_4').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block0_4', cj(var(v5), 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_1', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block1_1')).
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_1', fun_call('subO_array_dataslot_t_array$_t_address_$300_storage', [var(v0)], [var(v9)])).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_1', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_2').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_2', asgn(var(v13), expr(mul([num(0x01), var(v1)])))).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_2', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_3').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_3', asgn(var(v14), expr(add([var(v13), var(v9)])))).
nextlab('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block2_3', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_ret').
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_ret', ret([var(v14), num(0x00)])).
at('lottery_0xaa45a54c', 'subO_storage_array_index_access_t_array$_t_address_$300_storage_Block1_1', fun_call(subO_panic_error_0x32, [], [])).
at('lottery_0xaa45a54c', 'subO_zero_value_for_split_t_uint256_ret', ret([num(0x00)])).
at('lottery_0xaa45a54c', 'start_contract', fun_call(init_contract, [], [])).
nextlab('lottery_0xaa45a54c', 'start_contract', 'runtime_contract').
at('lottery_0xaa45a54c', 'runtime_contract', fun_call(r_Lottery_80_deployed, [], [])).
at('lottery_0xaa45a54c', 'init_contract_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('lottery_0xaa45a54c', 'init_contract_Block0_1', 'init_contract_Block0_2').
at('lottery_0xaa45a54c', 'init_contract_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('lottery_0xaa45a54c', 'init_contract_Block0_2', 'init_contract_Block0_3').
at('lottery_0xaa45a54c', 'init_contract_Block0_3', asgn(var(v2), expr(callvalue))).
nextlab('lottery_0xaa45a54c', 'init_contract_Block0_3', 'init_contract_Block0_4').
at('lottery_0xaa45a54c', 'init_contract_Block0_4', cj(var(v2), 'init_contract_Block2_1', 'init_contract_Block1_1')).
at('lottery_0xaa45a54c', 'init_contract_Block2_1', fun_call(obj_copy_arguments_for_constructor_28_object_Lottery_80, [], [var(v3)])).
nextlab('lottery_0xaa45a54c', 'init_contract_Block2_1', 'init_contract_Block2_2').
at('lottery_0xaa45a54c', 'init_contract_Block2_2', fun_call(obj_constructor_Lottery_80, [var(v3)], [])).
nextlab('lottery_0xaa45a54c', 'init_contract_Block2_2', 'init_contract_ret').
at('lottery_0xaa45a54c', 'init_contract_ret', ret([])).
at('lottery_0xaa45a54c', 'init_contract_Block1_1', fun_call(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_1', mstore([num(0x80), mem(0x40)])).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_1', 'Lottery_80_deployed_Block0_2').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_2', asgn(var(v3), expr(calldatasize))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_2', 'Lottery_80_deployed_Block0_3').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_3', asgn(var(v4), expr(lt([num(0x04), var(v3)])))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_3', 'Lottery_80_deployed_Block0_4').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_4', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_4', 'Lottery_80_deployed_Block0_5').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block0_5', cj(var(v5), 'Lottery_80_deployed_Block2_1', 'Lottery_80_deployed_Block1_1')).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block2_1', fun_call(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [])).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_1', asgn(var(v7), expr(calldataload([num(0x00)])))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_1', 'Lottery_80_deployed_Block1_2').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_2', fun_call(subO_shift_right_224_unsigned, [var(v7)], [var(v8)])).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_2', 'Lottery_80_deployed_Block1_3').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_3', asgn(var(v9), expr(eq([num(0x5d495aea), var(v8)])))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_3', 'Lottery_80_deployed_Block1_4').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block1_4', cj(var(v9), 'Lottery_80_deployed_Block5_1', 'Lottery_80_deployed_Block4_1')).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block5_1', asgn(var(v11), expr(eq([num(0xe97dcb62), var(v8)])))).
nextlab('lottery_0xaa45a54c', 'Lottery_80_deployed_Block5_1', 'Lottery_80_deployed_Block5_2').
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block5_2', cj(var(v11), 'Lottery_80_deployed_Block8_1', 'Lottery_80_deployed_Block7_1')).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block4_1', fun_call(subO_external_fun_pickWinner_72, [], [])).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block8_1', goto('Lottery_80_deployed_Block3_1')).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block7_1', fun_call(subO_external_fun_enter_59, [], [])).
at('lottery_0xaa45a54c', 'Lottery_80_deployed_Block3_1', goto('Lottery_80_deployed_Block2_1')).
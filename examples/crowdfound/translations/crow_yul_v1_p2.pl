address([(0x71d1a48c,'crowdfund')]).

% crow_yul_v1_p2.sol:Crowdfund contract
:- dynamic at/3.
:- discontiguous at/3.
:- discontiguous nextlab/3.
:- discontiguous globals/2.
:- discontiguous signatures/2.
:- discontiguous memory/2.
:- discontiguous fun/5.

signatures('crowdfund', [('external_fun_withdraw_34', '0x3ccfd60b00000000000000000000000000000000000000000000000000000000'), ('external_fun_reclaim_39', '0x80e9071b00000000000000000000000000000000000000000000000000000000'), ('external_fun__check_invariants_78', '0xc61b5a5900000000000000000000000000000000000000000000000000000000'), ('external_fun_donate_29', '0xed88c68e00000000000000000000000000000000000000000000000000000000'), ('external_fun_totalHeld_9', '0xf43cc77300000000000000000000000000000000000000000000000000000000')]).

globals('crowdfund', [(address, 0x71d1a48c), 0x00, 0x01, 0x02, 0x03, 0x04]).
memory('crowdfund', [0x00, 0x04, 0x40, 0x80, 0x128, 0xa0, 0xc0, 0xe0]).

fun('crowdfund', obj_abi_decode_t_address_fromMemory, [var(v0), var(v1)], [var(v3)], 'obj_abi_decode_t_address_fromMemory_Block0_1').
fun('crowdfund', obj_abi_decode_t_address_payable_fromMemory, [var(v0), var(v1)], [var(v3)], 'obj_abi_decode_t_address_payable_fromMemory_Block0_1').
fun('crowdfund', obj_abi_decode_t_uint256_fromMemory, [var(v0), var(v1)], [var(v3)], 'obj_abi_decode_t_uint256_fromMemory_Block0_1').
fun('crowdfund', obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory, [var(v0), var(v1)], [var(v21), var(v11), var(v15), var(v20), var(v4), var(v14), var(v12), var(v5), var(v17), var(v18)], 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_1').
fun('crowdfund', obj_allocate_memory, [var(v0)], [var(v2)], 'obj_allocate_memory_Block0_1').
fun('crowdfund', obj_allocate_unbounded, [], [var(v2)], 'obj_allocate_unbounded_Block0_1').
fun('crowdfund', obj_cleanup_t_address, [var(v0)], [var(v2)], 'obj_cleanup_t_address_Block0_1').
fun('crowdfund', obj_cleanup_t_address_payable, [var(v0)], [var(v2)], 'obj_cleanup_t_address_payable_Block0_1').
fun('crowdfund', obj_cleanup_t_uint160, [var(v0)], [var(v3)], 'obj_cleanup_t_uint160_Block0_1').
fun('crowdfund', obj_cleanup_t_uint256, [var(v0)], [], 'obj_cleanup_t_uint256_ret').
fun('crowdfund', obj_constructor_Crowdfund_79, [var(v0), var(v1), var(v2), var(v3)], [], 'obj_constructor_Crowdfund_79_Block0_1').
fun('crowdfund', obj_copy_arguments_for_constructor_24_object_Crowdfund_79, [], [var(v2), var(v7), var(v3), var(v1), var(v9), var(v4), var(v8), var(v5), var(v6)], 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_1').
fun('crowdfund', obj_finalize_allocation, [var(v0), var(v1)], [var(v2), var(v7), var(v3), var(v4), var(v6)], 'obj_finalize_allocation_Block0_1').
fun('crowdfund', obj_panic_error_0x41, [], [], 'obj_panic_error_0x41_Block0_1').
fun('crowdfund', obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db, [], [], 'obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1').
fun('crowdfund', obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('crowdfund', obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('crowdfund', obj_round_up_to_mul_of_32, [var(v0)], [var(v4), var(v5), var(v3)], 'obj_round_up_to_mul_of_32_Block0_1').
fun('crowdfund', obj_validator_revert_t_address, [var(v0)], [var(v1), var(v2), var(v3)], 'obj_validator_revert_t_address_Block0_1').
fun('crowdfund', obj_validator_revert_t_address_payable, [var(v0)], [var(v1), var(v2), var(v3)], 'obj_validator_revert_t_address_payable_Block0_1').
fun('crowdfund', obj_validator_revert_t_uint256, [var(v0)], [var(v1), var(v2), var(v3)], 'obj_validator_revert_t_uint256_Block0_1').
fun('crowdfund', subO_abi_decode_tuple_, [var(v0), var(v1)], [var(v4), var(v3)], 'subO_abi_decode_tuple__Block0_1').
fun('crowdfund', subO_abi_encode_t_uint256_to_t_uint256_fromStack, [var(v0), var(v1)], [var(v2)], 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_1').
fun('crowdfund', subO_abi_encode_tuple__to__fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple__to__fromStack_Block0_1').
fun('crowdfund', subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack, [var(v0), var(v1)], [var(v4), var(v5)], 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_1').
fun('crowdfund', subO_allocate_memory, [var(v0)], [var(v2)], 'subO_allocate_memory_Block0_1').
fun('crowdfund', subO_allocate_memory_array_t_bytes_memory_ptr, [var(v0)], [var(v2), var(v3)], 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1').
fun('crowdfund', subO_allocate_unbounded, [], [var(v2)], 'subO_allocate_unbounded_Block0_1').
fun('crowdfund', subO_array_allocation_size_t_bytes_memory_ptr, [var(v0)], [var(v7), var(v9), var(v3)], 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1').
fun('crowdfund', subO_assert_helper, [var(v0)], [var(v1)], 'subO_assert_helper_Block0_1').
fun('crowdfund', subO_cleanup_from_storage_t_uint256, [var(v0)], [], 'subO_cleanup_from_storage_t_uint256_ret').
fun('crowdfund', subO_cleanup_t_bytes4, [var(v0)], [var(v3)], 'subO_cleanup_t_bytes4_Block0_1').
fun('crowdfund', subO_cleanup_t_uint160, [var(v0)], [var(v3)], 'subO_cleanup_t_uint160_Block0_1').
fun('crowdfund', subO_cleanup_t_uint256, [var(v0)], [], 'subO_cleanup_t_uint256_ret').
fun('crowdfund', subO_cleanup_t_uint32, [var(v0)], [var(v3)], 'subO_cleanup_t_uint32_Block0_1').
fun('crowdfund', 'subO_convert_t_contract$_Crowdfund_$79_to_t_address', [var(v0)], [var(v2)], 'subO_convert_t_contract$_Crowdfund_$79_to_t_address_Block0_1').
fun('crowdfund', subO_convert_t_uint160_to_t_address, [var(v0)], [var(v2)], 'subO_convert_t_uint160_to_t_address_Block0_1').
fun('crowdfund', subO_convert_t_uint160_to_t_uint160, [var(v0)], [var(v4), var(v2), var(v3)], 'subO_convert_t_uint160_to_t_uint160_Block0_1').
fun('crowdfund', subO_convert_t_uint32_to_t_bytes4, [var(v0)], [var(v4), var(v2), var(v3)], 'subO_convert_t_uint32_to_t_bytes4_Block0_1').
fun('crowdfund', subO_external_fun__check_invariants_78, [], [var(v4), var(v2), var(v0), var(v3)], 'subO_external_fun__check_invariants_78_Block0_1').
fun('crowdfund', subO_external_fun_donate_29, [], [var(v4), var(v2), var(v0), var(v3)], 'subO_external_fun_donate_29_Block0_1').
fun('crowdfund', subO_external_fun_reclaim_39, [], [var(v0), var(v3), var(v1), var(v4), var(v5)], 'subO_external_fun_reclaim_39_Block0_1').
fun('crowdfund', subO_external_fun_totalHeld_9, [], [var(v0), var(v3), var(v1), var(v4), var(v5), var(v6)], 'subO_external_fun_totalHeld_9_Block0_1').
fun('crowdfund', subO_external_fun_withdraw_34, [], [var(v0), var(v3), var(v1), var(v4), var(v5)], 'subO_external_fun_withdraw_34_Block0_1').
fun('crowdfund', subO_extract_from_storage_value_dynamict_uint256, [var(v0), var(v1)], [var(v4), var(v5), var(v6)], 'subO_extract_from_storage_value_dynamict_uint256_Block0_1').
fun('crowdfund', subO_extract_from_storage_value_offset_0_t_uint256, [var(v0)], [var(v2), var(v3)], 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1').
fun('crowdfund', subO_extract_returndata, [], [var(v2), var(v3), var(v1), var(v9), var(v4), var(v8), var(v5), var(v6)], 'subO_extract_returndata_Block0_1').
fun('crowdfund', subO_finalize_allocation, [var(v0), var(v1)], [var(v2), var(v7), var(v3), var(v4), var(v6)], 'subO_finalize_allocation_Block0_1').
fun('crowdfund', subO_fun__check_invariants_78, [], [var(v23), var(v0), var(v29), var(v12), var(v5), var(v28), var(v2), var(v21), var(v20), var(v31), var(v25), var(v22), var(v27), var(v17), var(v32), var(v7), var(v11), var(v30), var(v3), var(v15), var(v10), var(v24), var(v4), var(v14), var(v8), var(v9), var(v19), var(v26)], 'subO_fun__check_invariants_78_Block0_1').
fun('crowdfund', subO_fun_donate_29, [], [var(v2), var(v7), var(v3), var(v1), var(v5), var(v6)], 'subO_fun_donate_29_Block0_1').
fun('crowdfund', subO_fun_reclaim_39, [], [var(v2), var(v7), var(v21), var(v3), var(v1), var(v9), var(v13), var(v4), var(v20), var(v14), var(v8), var(v12), var(v6), var(v22), var(v19), var(v10)], 'subO_fun_reclaim_39_Block0_1').
fun('crowdfund', subO_fun_withdraw_34, [], [var(v2), var(v7), var(v11), var(v3), var(v1), var(v9), var(v15), var(v4), var(v14), var(v8), var(v12), var(v6), var(v16), var(v17)], 'subO_fun_withdraw_34_Block0_1').
fun('crowdfund', subO_getter_fun_totalHeld_9, [], [var(v2)], 'subO_getter_fun_totalHeld_9_Block0_1').
fun('crowdfund', subO_identity, [var(v0)], [], 'subO_identity_ret').
fun('crowdfund', subO_panic_error_0x01, [], [], 'subO_panic_error_0x01_Block0_1').
fun('crowdfund', subO_panic_error_0x41, [], [], 'subO_panic_error_0x41_Block0_1').
fun('crowdfund', subO_read_from_storage_split_dynamic_t_uint256, [var(v0), var(v1)], [var(v4), var(v3)], 'subO_read_from_storage_split_dynamic_t_uint256_Block0_1').
fun('crowdfund', subO_read_from_storage_split_offset_0_t_uint256, [var(v0)], [var(v2), var(v3)], 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1').
fun('crowdfund', subO_require_helper, [var(v0)], [var(v1)], 'subO_require_helper_Block0_1').
fun('crowdfund', subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [], 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1').
fun('crowdfund', subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('crowdfund', subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('crowdfund', subO_round_up_to_mul_of_32, [var(v0)], [var(v4), var(v5), var(v3)], 'subO_round_up_to_mul_of_32_Block0_1').
fun('crowdfund', subO_shift_left_224, [var(v0)], [var(v3)], 'subO_shift_left_224_Block0_1').
fun('crowdfund', subO_shift_right_0_unsigned, [var(v0)], [var(v2)], 'subO_shift_right_0_unsigned_Block0_1').
fun('crowdfund', subO_shift_right_224_unsigned, [var(v0)], [var(v3)], 'subO_shift_right_224_unsigned_Block0_1').
fun('crowdfund', subO_shift_right_unsigned_dynamic, [var(v0), var(v1)], [var(v3)], 'subO_shift_right_unsigned_dynamic_Block0_1').
fun('crowdfund', subO_zero_value_for_split_t_bytes_memory_ptr, [], [], 'subO_zero_value_for_split_t_bytes_memory_ptr_ret').
fun('crowdfund', r_Crowdfund_79_deployed, [], [var(v7), var(v11), var(v3), var(v15), var(v13), var(v4), var(v8), var(v5), var(v9), var(v17)], 'Crowdfund_79_deployed_Block0_1').
fun('crowdfund', init_contract, [], [var(v2), var(v7), var(v0), var(v3), var(v9), var(v4), var(v8), var(v5), var(v6), var(v10)], 'init_contract_Block0_1').

at('crowdfund', 'obj_abi_decode_t_address_fromMemory_Block0_1', asgn(var(v3), expr(mload([var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_t_address_fromMemory_Block0_1', 'obj_abi_decode_t_address_fromMemory_Block0_2').
at('crowdfund', 'obj_abi_decode_t_address_fromMemory_Block0_2', fun_call(obj_validator_revert_t_address, [var(v3)], [])).
nextlab('crowdfund', 'obj_abi_decode_t_address_fromMemory_Block0_2', 'obj_abi_decode_t_address_fromMemory_ret').
at('crowdfund', 'obj_abi_decode_t_address_fromMemory_ret', ret([var(v3)])).
at('crowdfund', 'obj_abi_decode_t_address_payable_fromMemory_Block0_1', asgn(var(v3), expr(mload([var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_t_address_payable_fromMemory_Block0_1', 'obj_abi_decode_t_address_payable_fromMemory_Block0_2').
at('crowdfund', 'obj_abi_decode_t_address_payable_fromMemory_Block0_2', fun_call(obj_validator_revert_t_address_payable, [var(v3)], [])).
nextlab('crowdfund', 'obj_abi_decode_t_address_payable_fromMemory_Block0_2', 'obj_abi_decode_t_address_payable_fromMemory_ret').
at('crowdfund', 'obj_abi_decode_t_address_payable_fromMemory_ret', ret([var(v3)])).
at('crowdfund', 'obj_abi_decode_t_uint256_fromMemory_Block0_1', asgn(var(v3), expr(mload([var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_t_uint256_fromMemory_Block0_1', 'obj_abi_decode_t_uint256_fromMemory_Block0_2').
at('crowdfund', 'obj_abi_decode_t_uint256_fromMemory_Block0_2', fun_call(obj_validator_revert_t_uint256, [var(v3)], [])).
nextlab('crowdfund', 'obj_abi_decode_t_uint256_fromMemory_Block0_2', 'obj_abi_decode_t_uint256_fromMemory_ret').
at('crowdfund', 'obj_abi_decode_t_uint256_fromMemory_ret', ret([var(v3)])).
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_1', asgn(var(v4), expr(sub([var(v0), var(v1)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_1', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_2').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_2', asgn(var(v5), expr(slt([num(0x80), var(v4)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_2', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_3').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block0_3', cj(var(v5), 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_1', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block1_1')).
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_1', asgn(var(v11), expr(add([num(0x00), var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_1', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_2').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_2', fun_call(obj_abi_decode_t_address_payable_fromMemory, [var(v1), var(v11)], [var(v12)])).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_2', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_3').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_3', asgn(var(v14), expr(add([num(0x20), var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_3', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_4').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_4', fun_call(obj_abi_decode_t_uint256_fromMemory, [var(v1), var(v14)], [var(v15)])).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_4', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_5').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_5', asgn(var(v17), expr(add([num(0x40), var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_5', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_6').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_6', fun_call(obj_abi_decode_t_uint256_fromMemory, [var(v1), var(v17)], [var(v18)])).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_6', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_7').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_7', asgn(var(v20), expr(add([num(0x60), var(v0)])))).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_7', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_8').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_8', fun_call(obj_abi_decode_t_address_fromMemory, [var(v1), var(v20)], [var(v21)])).
nextlab('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block2_8', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_ret').
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_ret', ret([var(v12), var(v15), var(v18), var(v21)])).
at('crowdfund', 'obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory_Block1_1', fun_call(obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('crowdfund', 'obj_allocate_memory_Block0_1', fun_call(obj_allocate_unbounded, [], [var(v2)])).
nextlab('crowdfund', 'obj_allocate_memory_Block0_1', 'obj_allocate_memory_Block0_2').
at('crowdfund', 'obj_allocate_memory_Block0_2', fun_call(obj_finalize_allocation, [var(v0), var(v2)], [])).
nextlab('crowdfund', 'obj_allocate_memory_Block0_2', 'obj_allocate_memory_ret').
at('crowdfund', 'obj_allocate_memory_ret', ret([var(v2)])).
at('crowdfund', 'obj_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('crowdfund', 'obj_allocate_unbounded_Block0_1', 'obj_allocate_unbounded_ret').
at('crowdfund', 'obj_allocate_unbounded_ret', ret([var(v2)])).
at('crowdfund', 'obj_cleanup_t_address_Block0_1', fun_call(obj_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'obj_cleanup_t_address_Block0_1', 'obj_cleanup_t_address_ret').
at('crowdfund', 'obj_cleanup_t_address_ret', ret([var(v2)])).
at('crowdfund', 'obj_cleanup_t_address_payable_Block0_1', fun_call(obj_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'obj_cleanup_t_address_payable_Block0_1', 'obj_cleanup_t_address_payable_ret').
at('crowdfund', 'obj_cleanup_t_address_payable_ret', ret([var(v2)])).
at('crowdfund', 'obj_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('crowdfund', 'obj_cleanup_t_uint160_Block0_1', 'obj_cleanup_t_uint160_ret').
at('crowdfund', 'obj_cleanup_t_uint160_ret', ret([var(v3)])).
at('crowdfund', 'obj_cleanup_t_uint256_ret', ret([var(v0)])).
at('crowdfund', 'obj_constructor_Crowdfund_79_Block0_1', sstore([var(v1), off(0x00)])).
nextlab('crowdfund', 'obj_constructor_Crowdfund_79_Block0_1', 'obj_constructor_Crowdfund_79_Block0_2').
at('crowdfund', 'obj_constructor_Crowdfund_79_Block0_2', sstore([var(v2), off(0x01)])).
nextlab('crowdfund', 'obj_constructor_Crowdfund_79_Block0_2', 'obj_constructor_Crowdfund_79_Block0_3').
at('crowdfund', 'obj_constructor_Crowdfund_79_Block0_3', sstore([var(v0), off(0x02)])).
nextlab('crowdfund', 'obj_constructor_Crowdfund_79_Block0_3', 'obj_constructor_Crowdfund_79_Block0_4').
at('crowdfund', 'obj_constructor_Crowdfund_79_Block0_4', sstore([var(v3), off(0x04)])).
nextlab('crowdfund', 'obj_constructor_Crowdfund_79_Block0_4', 'obj_constructor_Crowdfund_79_ret').
at('crowdfund', 'obj_constructor_Crowdfund_79_ret', ret([])).
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_1', asgn(var(v1), expr(datasize))).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_1', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_2').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_2', asgn(var(v2), expr(codesize))).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_2', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_3').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_3', asgn(var(v3), expr(sub([var(v1), var(v2)])))).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_3', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_4').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_4', fun_call(obj_allocate_memory, [var(v3)], [var(v4)])).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_4', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_5').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_5', codecopy([var(v3), var(v1), var(v4)])).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_5', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_6').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_6', asgn(var(v5), expr(add([var(v3), var(v4)])))).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_6', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_7').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_7', fun_call(obj_abi_decode_tuple_t_address_payablet_uint256t_uint256t_address_fromMemory, [var(v5), var(v4)], [var(v6), var(v7), var(v8), var(v9)])).
nextlab('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_Block0_7', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_ret').
at('crowdfund', 'obj_copy_arguments_for_constructor_24_object_Crowdfund_79_ret', ret([var(v6), var(v7), var(v8), var(v9)])).
at('crowdfund', 'obj_finalize_allocation_Block0_1', fun_call(obj_round_up_to_mul_of_32, [var(v1)], [var(v2)])).
nextlab('crowdfund', 'obj_finalize_allocation_Block0_1', 'obj_finalize_allocation_Block0_2').
at('crowdfund', 'obj_finalize_allocation_Block0_2', asgn(var(v3), expr(add([var(v2), var(v0)])))).
nextlab('crowdfund', 'obj_finalize_allocation_Block0_2', 'obj_finalize_allocation_Block0_3').
at('crowdfund', 'obj_finalize_allocation_Block0_3', asgn(var(v4), expr(lt([var(v0), var(v3)])))).
nextlab('crowdfund', 'obj_finalize_allocation_Block0_3', 'obj_finalize_allocation_Block0_4').
at('crowdfund', 'obj_finalize_allocation_Block0_4', asgn(var(v6), expr(gt([num(0xffffffffffffffff), var(v3)])))).
nextlab('crowdfund', 'obj_finalize_allocation_Block0_4', 'obj_finalize_allocation_Block0_5').
at('crowdfund', 'obj_finalize_allocation_Block0_5', asgn(var(v7), expr(or([var(v4), var(v6)])))).
nextlab('crowdfund', 'obj_finalize_allocation_Block0_5', 'obj_finalize_allocation_Block0_6').
at('crowdfund', 'obj_finalize_allocation_Block0_6', cj(var(v7), 'obj_finalize_allocation_Block2_1', 'obj_finalize_allocation_Block1_1')).
at('crowdfund', 'obj_finalize_allocation_Block2_1', mstore([var(v3), mem(0x40)])).
nextlab('crowdfund', 'obj_finalize_allocation_Block2_1', 'obj_finalize_allocation_ret').
at('crowdfund', 'obj_finalize_allocation_ret', ret([])).
at('crowdfund', 'obj_finalize_allocation_Block1_1', fun_call(obj_panic_error_0x41, [], [])).
at('crowdfund', 'obj_panic_error_0x41_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('crowdfund', 'obj_panic_error_0x41_Block0_1', 'obj_panic_error_0x41_Block0_2').
at('crowdfund', 'obj_panic_error_0x41_Block0_2', mstore([num(0x41), mem(0x04)])).
nextlab('crowdfund', 'obj_panic_error_0x41_Block0_2', 'obj_panic_error_0x41_Block0_3').
at('crowdfund', 'obj_panic_error_0x41_Block0_3', revert([num(0x24), mem(0x00)])).
at('crowdfund', 'obj_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'obj_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'obj_round_up_to_mul_of_32_Block0_1', asgn(var(v3), expr(not([num(0x1f)])))).
nextlab('crowdfund', 'obj_round_up_to_mul_of_32_Block0_1', 'obj_round_up_to_mul_of_32_Block0_2').
at('crowdfund', 'obj_round_up_to_mul_of_32_Block0_2', asgn(var(v4), expr(add([num(0x1f), var(v0)])))).
nextlab('crowdfund', 'obj_round_up_to_mul_of_32_Block0_2', 'obj_round_up_to_mul_of_32_Block0_3').
at('crowdfund', 'obj_round_up_to_mul_of_32_Block0_3', asgn(var(v5), expr(and([var(v3), var(v4)])))).
nextlab('crowdfund', 'obj_round_up_to_mul_of_32_Block0_3', 'obj_round_up_to_mul_of_32_ret').
at('crowdfund', 'obj_round_up_to_mul_of_32_ret', ret([var(v5)])).
at('crowdfund', 'obj_validator_revert_t_address_Block0_1', fun_call(obj_cleanup_t_address, [var(v0)], [var(v1)])).
nextlab('crowdfund', 'obj_validator_revert_t_address_Block0_1', 'obj_validator_revert_t_address_Block0_2').
at('crowdfund', 'obj_validator_revert_t_address_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('crowdfund', 'obj_validator_revert_t_address_Block0_2', 'obj_validator_revert_t_address_Block0_3').
at('crowdfund', 'obj_validator_revert_t_address_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('crowdfund', 'obj_validator_revert_t_address_Block0_3', 'obj_validator_revert_t_address_Block0_4').
at('crowdfund', 'obj_validator_revert_t_address_Block0_4', cj(var(v3), 'obj_validator_revert_t_address_ret', 'obj_validator_revert_t_address_Block1_1')).
at('crowdfund', 'obj_validator_revert_t_address_ret', ret([])).
at('crowdfund', 'obj_validator_revert_t_address_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'obj_validator_revert_t_address_payable_Block0_1', fun_call(obj_cleanup_t_address_payable, [var(v0)], [var(v1)])).
nextlab('crowdfund', 'obj_validator_revert_t_address_payable_Block0_1', 'obj_validator_revert_t_address_payable_Block0_2').
at('crowdfund', 'obj_validator_revert_t_address_payable_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('crowdfund', 'obj_validator_revert_t_address_payable_Block0_2', 'obj_validator_revert_t_address_payable_Block0_3').
at('crowdfund', 'obj_validator_revert_t_address_payable_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('crowdfund', 'obj_validator_revert_t_address_payable_Block0_3', 'obj_validator_revert_t_address_payable_Block0_4').
at('crowdfund', 'obj_validator_revert_t_address_payable_Block0_4', cj(var(v3), 'obj_validator_revert_t_address_payable_ret', 'obj_validator_revert_t_address_payable_Block1_1')).
at('crowdfund', 'obj_validator_revert_t_address_payable_ret', ret([])).
at('crowdfund', 'obj_validator_revert_t_address_payable_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'obj_validator_revert_t_uint256_Block0_1', fun_call(obj_cleanup_t_uint256, [var(v0)], [var(v1)])).
nextlab('crowdfund', 'obj_validator_revert_t_uint256_Block0_1', 'obj_validator_revert_t_uint256_Block0_2').
at('crowdfund', 'obj_validator_revert_t_uint256_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('crowdfund', 'obj_validator_revert_t_uint256_Block0_2', 'obj_validator_revert_t_uint256_Block0_3').
at('crowdfund', 'obj_validator_revert_t_uint256_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('crowdfund', 'obj_validator_revert_t_uint256_Block0_3', 'obj_validator_revert_t_uint256_Block0_4').
at('crowdfund', 'obj_validator_revert_t_uint256_Block0_4', cj(var(v3), 'obj_validator_revert_t_uint256_ret', 'obj_validator_revert_t_uint256_Block1_1')).
at('crowdfund', 'obj_validator_revert_t_uint256_ret', ret([])).
at('crowdfund', 'obj_validator_revert_t_uint256_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_abi_decode_tuple__Block0_1', asgn(var(v3), expr(sub([var(v0), var(v1)])))).
nextlab('crowdfund', 'subO_abi_decode_tuple__Block0_1', 'subO_abi_decode_tuple__Block0_2').
at('crowdfund', 'subO_abi_decode_tuple__Block0_2', asgn(var(v4), expr(slt([num(0x00), var(v3)])))).
nextlab('crowdfund', 'subO_abi_decode_tuple__Block0_2', 'subO_abi_decode_tuple__Block0_3').
at('crowdfund', 'subO_abi_decode_tuple__Block0_3', cj(var(v4), 'subO_abi_decode_tuple__ret', 'subO_abi_decode_tuple__Block1_1')).
at('crowdfund', 'subO_abi_decode_tuple__ret', ret([])).
at('crowdfund', 'subO_abi_decode_tuple__Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('crowdfund', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_1', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_2').
at('crowdfund', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_2', mstore([var(v2), var(v1)])).
nextlab('crowdfund', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_Block0_2', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_ret').
at('crowdfund', 'subO_abi_encode_t_uint256_to_t_uint256_fromStack_ret', ret([])).
at('crowdfund', 'subO_abi_encode_tuple__to__fromStack_Block0_1', asgn(var(v2), expr(add([num(0x00), var(v0)])))).
nextlab('crowdfund', 'subO_abi_encode_tuple__to__fromStack_Block0_1', 'subO_abi_encode_tuple__to__fromStack_ret').
at('crowdfund', 'subO_abi_encode_tuple__to__fromStack_ret', ret([var(v2)])).
at('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_1', asgn(var(v4), expr(add([num(0x20), var(v0)])))).
nextlab('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_1', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_2').
at('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_2', asgn(var(v5), expr(add([num(0x00), var(v0)])))).
nextlab('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_2', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_3').
at('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_3', fun_call(subO_abi_encode_t_uint256_to_t_uint256_fromStack, [var(v5), var(v1)], [])).
nextlab('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_Block0_3', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_ret').
at('crowdfund', 'subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack_ret', ret([var(v4)])).
at('crowdfund', 'subO_allocate_memory_Block0_1', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('crowdfund', 'subO_allocate_memory_Block0_1', 'subO_allocate_memory_Block0_2').
at('crowdfund', 'subO_allocate_memory_Block0_2', fun_call(subO_finalize_allocation, [var(v0), var(v2)], [])).
nextlab('crowdfund', 'subO_allocate_memory_Block0_2', 'subO_allocate_memory_ret').
at('crowdfund', 'subO_allocate_memory_ret', ret([var(v2)])).
at('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1', fun_call(subO_array_allocation_size_t_bytes_memory_ptr, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2').
at('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2', fun_call(subO_allocate_memory, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3').
at('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3', mstore([var(v0), var(v3)])).
nextlab('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3', 'subO_allocate_memory_array_t_bytes_memory_ptr_ret').
at('crowdfund', 'subO_allocate_memory_array_t_bytes_memory_ptr_ret', ret([var(v3)])).
at('crowdfund', 'subO_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('crowdfund', 'subO_allocate_unbounded_Block0_1', 'subO_allocate_unbounded_ret').
at('crowdfund', 'subO_allocate_unbounded_ret', ret([var(v2)])).
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1', asgn(var(v3), expr(gt([num(0xffffffffffffffff), var(v0)])))).
nextlab('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_2').
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_2', cj(var(v3), 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block1_1')).
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', fun_call(subO_round_up_to_mul_of_32, [var(v0)], [var(v7)])).
nextlab('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2').
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2', asgn(var(v9), expr(add([num(0x20), var(v7)])))).
nextlab('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2', 'subO_array_allocation_size_t_bytes_memory_ptr_ret').
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_ret', ret([var(v9)])).
at('crowdfund', 'subO_array_allocation_size_t_bytes_memory_ptr_Block1_1', fun_call(subO_panic_error_0x41, [], [])).
at('crowdfund', 'subO_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('crowdfund', 'subO_assert_helper_Block0_1', 'subO_assert_helper_Block0_2').
at('crowdfund', 'subO_assert_helper_Block0_2', cj(var(v1), 'subO_assert_helper_ret', 'subO_assert_helper_Block1_1')).
at('crowdfund', 'subO_assert_helper_ret', ret([])).
at('crowdfund', 'subO_assert_helper_Block1_1', fun_call(subO_panic_error_0x01, [], [])).
at('crowdfund', 'subO_cleanup_from_storage_t_uint256_ret', ret([var(v0)])).
at('crowdfund', 'subO_cleanup_t_bytes4_Block0_1', asgn(var(v3), expr(and([num(0xffffffff00000000000000000000000000000000000000000000000000000000), var(v0)])))).
nextlab('crowdfund', 'subO_cleanup_t_bytes4_Block0_1', 'subO_cleanup_t_bytes4_ret').
at('crowdfund', 'subO_cleanup_t_bytes4_ret', ret([var(v3)])).
at('crowdfund', 'subO_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('crowdfund', 'subO_cleanup_t_uint160_Block0_1', 'subO_cleanup_t_uint160_ret').
at('crowdfund', 'subO_cleanup_t_uint160_ret', ret([var(v3)])).
at('crowdfund', 'subO_cleanup_t_uint256_ret', ret([var(v0)])).
at('crowdfund', 'subO_cleanup_t_uint32_Block0_1', asgn(var(v3), expr(and([num(0xffffffff), var(v0)])))).
nextlab('crowdfund', 'subO_cleanup_t_uint32_Block0_1', 'subO_cleanup_t_uint32_ret').
at('crowdfund', 'subO_cleanup_t_uint32_ret', ret([var(v3)])).
at('crowdfund', 'subO_convert_t_contract$_Crowdfund_$79_to_t_address_Block0_1', fun_call(subO_convert_t_uint160_to_t_address, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_convert_t_contract$_Crowdfund_$79_to_t_address_Block0_1', 'subO_convert_t_contract$_Crowdfund_$79_to_t_address_ret').
at('crowdfund', 'subO_convert_t_contract$_Crowdfund_$79_to_t_address_ret', ret([var(v2)])).
at('crowdfund', 'subO_convert_t_uint160_to_t_address_Block0_1', fun_call(subO_convert_t_uint160_to_t_uint160, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_convert_t_uint160_to_t_address_Block0_1', 'subO_convert_t_uint160_to_t_address_ret').
at('crowdfund', 'subO_convert_t_uint160_to_t_address_ret', ret([var(v2)])).
at('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_1', fun_call(subO_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_1', 'subO_convert_t_uint160_to_t_uint160_Block0_2').
at('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_2', 'subO_convert_t_uint160_to_t_uint160_Block0_3').
at('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_3', fun_call(subO_cleanup_t_uint160, [var(v3)], [var(v4)])).
nextlab('crowdfund', 'subO_convert_t_uint160_to_t_uint160_Block0_3', 'subO_convert_t_uint160_to_t_uint160_ret').
at('crowdfund', 'subO_convert_t_uint160_to_t_uint160_ret', ret([var(v4)])).
at('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_1', fun_call(subO_cleanup_t_uint32, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_1', 'subO_convert_t_uint32_to_t_bytes4_Block0_2').
at('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_2', fun_call(subO_shift_left_224, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_2', 'subO_convert_t_uint32_to_t_bytes4_Block0_3').
at('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_3', fun_call(subO_cleanup_t_bytes4, [var(v3)], [var(v4)])).
nextlab('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_Block0_3', 'subO_convert_t_uint32_to_t_bytes4_ret').
at('crowdfund', 'subO_convert_t_uint32_to_t_bytes4_ret', ret([var(v4)])).
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_1', 'subO_external_fun__check_invariants_78_Block0_2').
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_2', fun_call(subO_abi_decode_tuple_, [var(v0), num(0x04)], [])).
nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_2', 'subO_external_fun__check_invariants_78_Block0_3').


at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_3', fun_call(subO_fun__check_invariants_78, [], [])).
nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_3', 'subO_external_fun__check_invariants_78_Block0_4').
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v2)])).


nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_4', 'subO_external_fun__check_invariants_78_Block0_5').
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_5', 'subO_external_fun__check_invariants_78_Block0_6').
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_6', asgn(var(v4), expr(sub([var(v2), var(v3)])))).
nextlab('crowdfund', 'subO_external_fun__check_invariants_78_Block0_6', 'subO_external_fun__check_invariants_78_Block0_7').
at('crowdfund', 'subO_external_fun__check_invariants_78_Block0_7', return([var(v4), var(v2)])).
at('crowdfund', 'subO_external_fun_donate_29_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_1', 'subO_external_fun_donate_29_Block0_2').
at('crowdfund', 'subO_external_fun_donate_29_Block0_2', fun_call(subO_abi_decode_tuple_, [var(v0), num(0x04)], [])).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_2', 'subO_external_fun_donate_29_Block0_3').
at('crowdfund', 'subO_external_fun_donate_29_Block0_3', fun_call(subO_fun_donate_29, [], [])).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_3', 'subO_external_fun_donate_29_Block0_4').
at('crowdfund', 'subO_external_fun_donate_29_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_4', 'subO_external_fun_donate_29_Block0_5').
at('crowdfund', 'subO_external_fun_donate_29_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_5', 'subO_external_fun_donate_29_Block0_6').
at('crowdfund', 'subO_external_fun_donate_29_Block0_6', asgn(var(v4), expr(sub([var(v2), var(v3)])))).
nextlab('crowdfund', 'subO_external_fun_donate_29_Block0_6', 'subO_external_fun_donate_29_Block0_7').
at('crowdfund', 'subO_external_fun_donate_29_Block0_7', return([var(v4), var(v2)])).
at('crowdfund', 'subO_external_fun_reclaim_39_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block0_1', 'subO_external_fun_reclaim_39_Block0_2').
at('crowdfund', 'subO_external_fun_reclaim_39_Block0_2', cj(var(v0), 'subO_external_fun_reclaim_39_Block2_1', 'subO_external_fun_reclaim_39_Block1_1')).
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_1', 'subO_external_fun_reclaim_39_Block2_2').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_2', fun_call(subO_abi_decode_tuple_, [var(v1), num(0x04)], [])).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_2', 'subO_external_fun_reclaim_39_Block2_3').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_3', fun_call(subO_fun_reclaim_39, [], [])).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_3', 'subO_external_fun_reclaim_39_Block2_4').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v3)])).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_4', 'subO_external_fun_reclaim_39_Block2_5').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v3)], [var(v4)])).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_5', 'subO_external_fun_reclaim_39_Block2_6').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_6', asgn(var(v5), expr(sub([var(v3), var(v4)])))).
nextlab('crowdfund', 'subO_external_fun_reclaim_39_Block2_6', 'subO_external_fun_reclaim_39_Block2_7').
at('crowdfund', 'subO_external_fun_reclaim_39_Block2_7', return([var(v5), var(v3)])).
at('crowdfund', 'subO_external_fun_reclaim_39_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('crowdfund', 'subO_external_fun_totalHeld_9_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block0_1', 'subO_external_fun_totalHeld_9_Block0_2').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block0_2', cj(var(v0), 'subO_external_fun_totalHeld_9_Block2_1', 'subO_external_fun_totalHeld_9_Block1_1')).
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_1', 'subO_external_fun_totalHeld_9_Block2_2').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_2', fun_call(subO_abi_decode_tuple_, [var(v1), num(0x04)], [])).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_2', 'subO_external_fun_totalHeld_9_Block2_3').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_3', fun_call(subO_getter_fun_totalHeld_9, [], [var(v3)])).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_3', 'subO_external_fun_totalHeld_9_Block2_4').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v4)])).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_4', 'subO_external_fun_totalHeld_9_Block2_5').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_5', fun_call(subO_abi_encode_tuple_t_uint256__to_t_uint256__fromStack, [var(v3), var(v4)], [var(v5)])).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_5', 'subO_external_fun_totalHeld_9_Block2_6').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_6', asgn(var(v6), expr(sub([var(v4), var(v5)])))).
nextlab('crowdfund', 'subO_external_fun_totalHeld_9_Block2_6', 'subO_external_fun_totalHeld_9_Block2_7').
at('crowdfund', 'subO_external_fun_totalHeld_9_Block2_7', return([var(v6), var(v4)])).
at('crowdfund', 'subO_external_fun_totalHeld_9_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('crowdfund', 'subO_external_fun_withdraw_34_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block0_1', 'subO_external_fun_withdraw_34_Block0_2').
at('crowdfund', 'subO_external_fun_withdraw_34_Block0_2', cj(var(v0), 'subO_external_fun_withdraw_34_Block2_1', 'subO_external_fun_withdraw_34_Block1_1')).
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_1', 'subO_external_fun_withdraw_34_Block2_2').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_2', fun_call(subO_abi_decode_tuple_, [var(v1), num(0x04)], [])).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_2', 'subO_external_fun_withdraw_34_Block2_3').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_3', fun_call(subO_fun_withdraw_34, [], [])).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_3', 'subO_external_fun_withdraw_34_Block2_4').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v3)])).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_4', 'subO_external_fun_withdraw_34_Block2_5').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v3)], [var(v4)])).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_5', 'subO_external_fun_withdraw_34_Block2_6').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_6', asgn(var(v5), expr(sub([var(v3), var(v4)])))).
nextlab('crowdfund', 'subO_external_fun_withdraw_34_Block2_6', 'subO_external_fun_withdraw_34_Block2_7').
at('crowdfund', 'subO_external_fun_withdraw_34_Block2_7', return([var(v5), var(v3)])).
at('crowdfund', 'subO_external_fun_withdraw_34_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_1', asgn(var(v4), expr(mul([num(0x08), var(v1)])))).
nextlab('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_1', 'subO_extract_from_storage_value_dynamict_uint256_Block0_2').
at('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_2', fun_call(subO_shift_right_unsigned_dynamic, [var(v0), var(v4)], [var(v5)])).
nextlab('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_2', 'subO_extract_from_storage_value_dynamict_uint256_Block0_3').
at('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_3', fun_call(subO_cleanup_from_storage_t_uint256, [var(v5)], [var(v6)])).
nextlab('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_Block0_3', 'subO_extract_from_storage_value_dynamict_uint256_ret').
at('crowdfund', 'subO_extract_from_storage_value_dynamict_uint256_ret', ret([var(v6)])).
at('crowdfund', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', fun_call(subO_shift_right_0_unsigned, [var(v0)], [var(v2)])).
nextlab('crowdfund', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2').
at('crowdfund', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', fun_call(subO_cleanup_from_storage_t_uint256, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', 'subO_extract_from_storage_value_offset_0_t_uint256_ret').
at('crowdfund', 'subO_extract_from_storage_value_offset_0_t_uint256_ret', ret([var(v3)])).
at('crowdfund', 'subO_extract_returndata_Block0_1', asgn(var(v1), expr(returndatasize))).
nextlab('crowdfund', 'subO_extract_returndata_Block0_1', 'subO_extract_returndata_Block0_2').
at('crowdfund', 'subO_extract_returndata_Block0_2', asgn(var(v2), expr(eq([num(0x00), var(v1)])))).
nextlab('crowdfund', 'subO_extract_returndata_Block0_2', 'subO_extract_returndata_Block0_3').
at('crowdfund', 'subO_extract_returndata_Block0_3', cj(var(v2), 'subO_extract_returndata_Block3_1', 'subO_extract_returndata_Block2_1')).
at('crowdfund', 'subO_extract_returndata_Block3_1', asgn(var(v4), expr(returndatasize))).
nextlab('crowdfund', 'subO_extract_returndata_Block3_1', 'subO_extract_returndata_Block3_2').
at('crowdfund', 'subO_extract_returndata_Block3_2', fun_call(subO_allocate_memory_array_t_bytes_memory_ptr, [var(v4)], [var(v5)])).
nextlab('crowdfund', 'subO_extract_returndata_Block3_2', 'subO_extract_returndata_Block3_3').
at('crowdfund', 'subO_extract_returndata_Block3_3', asgn(var(v6), expr(returndatasize))).
nextlab('crowdfund', 'subO_extract_returndata_Block3_3', 'subO_extract_returndata_Block3_4').
at('crowdfund', 'subO_extract_returndata_Block3_4', asgn(var(v8), expr(add([num(0x20), var(v5)])))).
nextlab('crowdfund', 'subO_extract_returndata_Block3_4', 'subO_extract_returndata_Block3_5').
at('crowdfund', 'subO_extract_returndata_Block3_5', returndatacopy([var(v6), num(0x00), var(v8)])).
nextlab('crowdfund', 'subO_extract_returndata_Block3_5', 'subO_extract_returndata_Block3_6').
at('crowdfund', 'subO_extract_returndata_Block3_6', goto('subO_extract_returndata_Block1_1_2')).
at('crowdfund', 'subO_extract_returndata_Block2_1', fun_call(subO_zero_value_for_split_t_bytes_memory_ptr, [], [var(v3)])).
nextlab('crowdfund', 'subO_extract_returndata_Block2_1', 'subO_extract_returndata_Block2_2').
at('crowdfund', 'subO_extract_returndata_Block2_2', goto('subO_extract_returndata_Block1_1_1')).
at('crowdfund', 'subO_extract_returndata_Block1_1_1', asgn(var(v9), expr(phiFunction([var(v3)])))).
nextlab('crowdfund', 'subO_extract_returndata_Block1_1_1', 'subO_extract_returndata_ret').
at('crowdfund', 'subO_extract_returndata_Block1_1_2', asgn(var(v9), expr(phiFunction([var(v5)])))).
nextlab('crowdfund', 'subO_extract_returndata_Block1_1_2', 'subO_extract_returndata_ret').
at('crowdfund', 'subO_extract_returndata_ret', ret([var(v9)])).
at('crowdfund', 'subO_finalize_allocation_Block0_1', fun_call(subO_round_up_to_mul_of_32, [var(v1)], [var(v2)])).
nextlab('crowdfund', 'subO_finalize_allocation_Block0_1', 'subO_finalize_allocation_Block0_2').
at('crowdfund', 'subO_finalize_allocation_Block0_2', asgn(var(v3), expr(add([var(v2), var(v0)])))).
nextlab('crowdfund', 'subO_finalize_allocation_Block0_2', 'subO_finalize_allocation_Block0_3').
at('crowdfund', 'subO_finalize_allocation_Block0_3', asgn(var(v4), expr(lt([var(v0), var(v3)])))).
nextlab('crowdfund', 'subO_finalize_allocation_Block0_3', 'subO_finalize_allocation_Block0_4').
at('crowdfund', 'subO_finalize_allocation_Block0_4', asgn(var(v6), expr(gt([num(0xffffffffffffffff), var(v3)])))).
nextlab('crowdfund', 'subO_finalize_allocation_Block0_4', 'subO_finalize_allocation_Block0_5').
at('crowdfund', 'subO_finalize_allocation_Block0_5', asgn(var(v7), expr(or([var(v4), var(v6)])))).
nextlab('crowdfund', 'subO_finalize_allocation_Block0_5', 'subO_finalize_allocation_Block0_6').
at('crowdfund', 'subO_finalize_allocation_Block0_6', cj(var(v7), 'subO_finalize_allocation_Block2_1', 'subO_finalize_allocation_Block1_1')).
at('crowdfund', 'subO_finalize_allocation_Block2_1', mstore([var(v3), mem(0x40)])).
nextlab('crowdfund', 'subO_finalize_allocation_Block2_1', 'subO_finalize_allocation_ret').
at('crowdfund', 'subO_finalize_allocation_ret', ret([])).
at('crowdfund', 'subO_finalize_allocation_Block1_1', fun_call(subO_panic_error_0x41, [], [])).


at('crowdfund', 'subO_fun__check_invariants_78_Block0_1', asgn(var(v0), expr(number))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_1', 'subO_fun__check_invariants_78_Block0_2').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_2', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v2)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_2', 'subO_fun__check_invariants_78_Block0_3').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_3', 'subO_fun__check_invariants_78_Block0_4').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_4', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v4)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_4', 'subO_fun__check_invariants_78_Block0_5').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_5', asgn(var(v5), expr(gt([var(v3), var(v4)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_5', 'subO_fun__check_invariants_78_Block0_6').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_6', fun_call(subO_require_helper, [var(v5)], [])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_6', 'subO_fun__check_invariants_78_Block0_7').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_7', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x03)], [var(v7)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_7', 'subO_fun__check_invariants_78_Block0_8').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_8', asgn(var(v8), expr(address))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_8', 'subO_fun__check_invariants_78_Block0_9').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_9', fun_call('subO_convert_t_contract$_Crowdfund_$79_to_t_address', [var(v8)], [var(v9)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_9', 'subO_fun__check_invariants_78_Block0_10').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_10', asgn(var(v10), expr(callvalue))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_10', 'subO_fun__check_invariants_78_Block0_11').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_11', asgn(var(v11), expr(address))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_11', 'subO_fun__check_invariants_78_Block0_12').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_12', fun_call('subO_convert_t_contract$_Crowdfund_$79_to_t_address', [var(v11)], [var(v12)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_12', 'subO_fun__check_invariants_78_Block0_13').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_13', fun_call(subO_convert_t_uint32_to_t_bytes4, [num(0xed88c68e)], [var(v14)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_13', 'subO_fun__check_invariants_78_Block0_14').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_14', fun_call(subO_allocate_unbounded, [], [var(v15)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_14', 'subO_fun__check_invariants_78_Block0_15').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_15', asgn(var(v17), expr(add([num(0x20), var(v15)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_15', 'subO_fun__check_invariants_78_Block0_16').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_16', mstore([var(v14), var(v17)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_16', 'subO_fun__check_invariants_78_Block0_17').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_17', asgn(var(v19), expr(add([num(0x04), var(v17)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_17', 'subO_fun__check_invariants_78_Block0_18').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_18', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v19)], [var(v20)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_18', 'subO_fun__check_invariants_78_Block0_19').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_19', asgn(var(v21), expr(add([num(0x20), var(v15)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_19', 'subO_fun__check_invariants_78_Block0_20').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_20', asgn(var(v22), expr(sub([var(v21), var(v20)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_20', 'subO_fun__check_invariants_78_Block0_21').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_21', mstore([var(v22), var(v15)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_21', 'subO_fun__check_invariants_78_Block0_22').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_22', asgn(var(v23), expr(sub([var(v15), var(v20)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_22', 'subO_fun__check_invariants_78_Block0_23').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_23', fun_call(subO_finalize_allocation, [var(v23), var(v15)], [])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_23', 'subO_fun__check_invariants_78_Block0_24').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_24', asgn(var(v24), expr(add([num(0x20), var(v15)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_24', 'subO_fun__check_invariants_78_Block0_25').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_25', asgn(var(v25), expr(mload([var(v15)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_25', 'subO_fun__check_invariants_78_Block0_26').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_26', asgn(var(v26), expr(gas))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_26', 'subO_fun__check_invariants_78_Block0_27').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_27', call([num(0x00), num(0x00), var(v25), var(v24), var(v10), var(v9), var(v26)], var(v27))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_27', 'subO_fun__check_invariants_78_Block0_28').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_28', fun_call(subO_extract_returndata, [], [var(v28)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_28', 'subO_fun__check_invariants_78_Block0_29').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_29', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x03)], [var(v29)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_29', 'subO_fun__check_invariants_78_Block0_30').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_30', fun_call(subO_cleanup_t_uint256, [var(v7)], [var(v30)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_30', 'subO_fun__check_invariants_78_Block0_31').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_31', fun_call(subO_cleanup_t_uint256, [var(v29)], [var(v31)])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_31', 'subO_fun__check_invariants_78_Block0_32').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_32', asgn(var(v32), expr(eq([var(v30), var(v31)])))).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_32', 'subO_fun__check_invariants_78_Block0_33').
at('crowdfund', 'subO_fun__check_invariants_78_Block0_33', fun_call(subO_assert_helper, [var(v32)], [])).
nextlab('crowdfund', 'subO_fun__check_invariants_78_Block0_33', 'subO_fun__check_invariants_78_ret').
at('crowdfund', 'subO_fun__check_invariants_78_ret', ret([])).



at('crowdfund', 'subO_fun_donate_29_Block0_1', asgn(var(v1), expr(sload([off(0x00)])))).
nextlab('crowdfund', 'subO_fun_donate_29_Block0_1', 'subO_fun_donate_29_Block0_2').
at('crowdfund', 'subO_fun_donate_29_Block0_2', asgn(var(v2), expr(number))).
nextlab('crowdfund', 'subO_fun_donate_29_Block0_2', 'subO_fun_donate_29_Block0_3').
at('crowdfund', 'subO_fun_donate_29_Block0_3', asgn(var(v3), expr(gt([var(v1), var(v2)])))).
nextlab('crowdfund', 'subO_fun_donate_29_Block0_3', 'subO_fun_donate_29_Block0_4').
at('crowdfund', 'subO_fun_donate_29_Block0_4', cj(var(v3), 'subO_fun_donate_29_Block2_1', 'subO_fun_donate_29_Block1_1')).
at('crowdfund', 'subO_fun_donate_29_Block2_1', asgn(var(v5), expr(sload([off(0x03)])))).
nextlab('crowdfund', 'subO_fun_donate_29_Block2_1', 'subO_fun_donate_29_Block2_2').
at('crowdfund', 'subO_fun_donate_29_Block2_2', asgn(var(v6), expr(callvalue))).
nextlab('crowdfund', 'subO_fun_donate_29_Block2_2', 'subO_fun_donate_29_Block2_3').
at('crowdfund', 'subO_fun_donate_29_Block2_3', asgn(var(v7), expr(add([var(v6), var(v5)])))).
nextlab('crowdfund', 'subO_fun_donate_29_Block2_3', 'subO_fun_donate_29_Block2_4').
at('crowdfund', 'subO_fun_donate_29_Block2_4', sstore([var(v7), off(0x03)])).
nextlab('crowdfund', 'subO_fun_donate_29_Block2_4', 'subO_fun_donate_29_ret').
at('crowdfund', 'subO_fun_donate_29_ret', ret([])).
at('crowdfund', 'subO_fun_donate_29_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_reclaim_39_Block0_1', asgn(var(v1), expr(sload([off(0x00)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block0_1', 'subO_fun_reclaim_39_Block0_2').
at('crowdfund', 'subO_fun_reclaim_39_Block0_2', asgn(var(v2), expr(number))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block0_2', 'subO_fun_reclaim_39_Block0_3').
at('crowdfund', 'subO_fun_reclaim_39_Block0_3', asgn(var(v3), expr(gt([var(v1), var(v2)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block0_3', 'subO_fun_reclaim_39_Block0_4').
at('crowdfund', 'subO_fun_reclaim_39_Block0_4', asgn(var(v4), expr(iszero([var(v3)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block0_4', 'subO_fun_reclaim_39_Block0_5').
at('crowdfund', 'subO_fun_reclaim_39_Block0_5', cj(var(v4), 'subO_fun_reclaim_39_Block2_1', 'subO_fun_reclaim_39_Block1_1')).
at('crowdfund', 'subO_fun_reclaim_39_Block2_1', asgn(var(v6), expr(sload([off(0x01)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block2_1', 'subO_fun_reclaim_39_Block2_2').
at('crowdfund', 'subO_fun_reclaim_39_Block2_2', asgn(var(v7), expr(address))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block2_2', 'subO_fun_reclaim_39_Block2_3').
at('crowdfund', 'subO_fun_reclaim_39_Block2_3', asgn(var(v8), expr(balance([var(v7)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block2_3', 'subO_fun_reclaim_39_Block2_4').
at('crowdfund', 'subO_fun_reclaim_39_Block2_4', asgn(var(v9), expr(lt([var(v6), var(v8)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block2_4', 'subO_fun_reclaim_39_Block2_5').
at('crowdfund', 'subO_fun_reclaim_39_Block2_5', asgn(var(v10), expr(iszero([var(v9)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block2_5', 'subO_fun_reclaim_39_Block2_6').
at('crowdfund', 'subO_fun_reclaim_39_Block2_6', cj(var(v10), 'subO_fun_reclaim_39_Block5_1', 'subO_fun_reclaim_39_Block4_1')).
at('crowdfund', 'subO_fun_reclaim_39_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_reclaim_39_Block5_1', asgn(var(v12), expr(sload([off(0x03)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block5_1', 'subO_fun_reclaim_39_Block5_2').
at('crowdfund', 'subO_fun_reclaim_39_Block5_2', asgn(var(v13), expr(gt([num(0x00), var(v12)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block5_2', 'subO_fun_reclaim_39_Block5_3').
at('crowdfund', 'subO_fun_reclaim_39_Block5_3', asgn(var(v14), expr(iszero([var(v13)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block5_3', 'subO_fun_reclaim_39_Block5_4').
at('crowdfund', 'subO_fun_reclaim_39_Block5_4', cj(var(v14), 'subO_fun_reclaim_39_Block8_1', 'subO_fun_reclaim_39_Block7_1')).
at('crowdfund', 'subO_fun_reclaim_39_Block4_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_reclaim_39_Block8_1', sstore([num(0x00), off(0x03)])).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block8_1', 'subO_fun_reclaim_39_Block8_2').
at('crowdfund', 'subO_fun_reclaim_39_Block8_2', asgn(var(v19), expr(sload([off(0x04)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block8_2', 'subO_fun_reclaim_39_Block8_3').
at('crowdfund', 'subO_fun_reclaim_39_Block8_3', asgn(var(v20), expr(gas))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block8_3', 'subO_fun_reclaim_39_Block8_4').
at('crowdfund', 'subO_fun_reclaim_39_Block8_4', call([num(0x00), num(0x00), num(0x00), num(0x00), var(v12), var(v19), var(v20)], var(v21))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block8_4', 'subO_fun_reclaim_39_Block8_5').
at('crowdfund', 'subO_fun_reclaim_39_Block8_5', asgn(var(v22), expr(iszero([var(v21)])))).
nextlab('crowdfund', 'subO_fun_reclaim_39_Block8_5', 'subO_fun_reclaim_39_Block8_6').
at('crowdfund', 'subO_fun_reclaim_39_Block8_6', cj(var(v22), 'subO_fun_reclaim_39_ret', 'subO_fun_reclaim_39_Block10_1')).
at('crowdfund', 'subO_fun_reclaim_39_Block7_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_reclaim_39_ret', ret([])).
at('crowdfund', 'subO_fun_reclaim_39_Block10_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_withdraw_34_Block0_1', asgn(var(v1), expr(sload([off(0x00)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block0_1', 'subO_fun_withdraw_34_Block0_2').
at('crowdfund', 'subO_fun_withdraw_34_Block0_2', asgn(var(v2), expr(number))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block0_2', 'subO_fun_withdraw_34_Block0_3').
at('crowdfund', 'subO_fun_withdraw_34_Block0_3', asgn(var(v3), expr(gt([var(v1), var(v2)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block0_3', 'subO_fun_withdraw_34_Block0_4').
at('crowdfund', 'subO_fun_withdraw_34_Block0_4', asgn(var(v4), expr(iszero([var(v3)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block0_4', 'subO_fun_withdraw_34_Block0_5').
at('crowdfund', 'subO_fun_withdraw_34_Block0_5', cj(var(v4), 'subO_fun_withdraw_34_Block2_1', 'subO_fun_withdraw_34_Block1_1')).
at('crowdfund', 'subO_fun_withdraw_34_Block2_1', asgn(var(v6), expr(sload([off(0x01)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block2_1', 'subO_fun_withdraw_34_Block2_2').
at('crowdfund', 'subO_fun_withdraw_34_Block2_2', asgn(var(v7), expr(address))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block2_2', 'subO_fun_withdraw_34_Block2_3').
at('crowdfund', 'subO_fun_withdraw_34_Block2_3', asgn(var(v8), expr(balance([var(v7)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block2_3', 'subO_fun_withdraw_34_Block2_4').
at('crowdfund', 'subO_fun_withdraw_34_Block2_4', asgn(var(v9), expr(lt([var(v6), var(v8)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block2_4', 'subO_fun_withdraw_34_Block2_5').
at('crowdfund', 'subO_fun_withdraw_34_Block2_5', cj(var(v9), 'subO_fun_withdraw_34_Block5_1', 'subO_fun_withdraw_34_Block4_1')).
at('crowdfund', 'subO_fun_withdraw_34_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_withdraw_34_Block5_1', sstore([num(0x00), off(0x03)])).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_1', 'subO_fun_withdraw_34_Block5_2').
at('crowdfund', 'subO_fun_withdraw_34_Block5_2', asgn(var(v11), expr(address))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_2', 'subO_fun_withdraw_34_Block5_3').
at('crowdfund', 'subO_fun_withdraw_34_Block5_3', asgn(var(v12), expr(balance([var(v11)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_3', 'subO_fun_withdraw_34_Block5_4').
at('crowdfund', 'subO_fun_withdraw_34_Block5_4', asgn(var(v14), expr(sload([off(0x02)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_4', 'subO_fun_withdraw_34_Block5_5').
at('crowdfund', 'subO_fun_withdraw_34_Block5_5', asgn(var(v15), expr(gas))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_5', 'subO_fun_withdraw_34_Block5_6').
at('crowdfund', 'subO_fun_withdraw_34_Block5_6', call([num(0x00), num(0x00), num(0x00), num(0x00), var(v12), var(v14), var(v15)], var(v16))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_6', 'subO_fun_withdraw_34_Block5_7').
at('crowdfund', 'subO_fun_withdraw_34_Block5_7', asgn(var(v17), expr(iszero([var(v16)])))).
nextlab('crowdfund', 'subO_fun_withdraw_34_Block5_7', 'subO_fun_withdraw_34_Block5_8').
at('crowdfund', 'subO_fun_withdraw_34_Block5_8', cj(var(v17), 'subO_fun_withdraw_34_ret', 'subO_fun_withdraw_34_Block7_1')).
at('crowdfund', 'subO_fun_withdraw_34_Block4_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_fun_withdraw_34_ret', ret([])).
at('crowdfund', 'subO_fun_withdraw_34_Block7_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_getter_fun_totalHeld_9_Block0_1', fun_call(subO_read_from_storage_split_dynamic_t_uint256, [num(0x00), num(0x03)], [var(v2)])).
nextlab('crowdfund', 'subO_getter_fun_totalHeld_9_Block0_1', 'subO_getter_fun_totalHeld_9_ret').
at('crowdfund', 'subO_getter_fun_totalHeld_9_ret', ret([var(v2)])).
at('crowdfund', 'subO_identity_ret', ret([var(v0)])).
at('crowdfund', 'subO_panic_error_0x01_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('crowdfund', 'subO_panic_error_0x01_Block0_1', 'subO_panic_error_0x01_Block0_2').
at('crowdfund', 'subO_panic_error_0x01_Block0_2', mstore([num(0x01), mem(0x04)])).
nextlab('crowdfund', 'subO_panic_error_0x01_Block0_2', 'subO_panic_error_0x01_Block0_3').
at('crowdfund', 'subO_panic_error_0x01_Block0_3', revert([num(0x24), mem(0x00)])).
at('crowdfund', 'subO_panic_error_0x41_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('crowdfund', 'subO_panic_error_0x41_Block0_1', 'subO_panic_error_0x41_Block0_2').
at('crowdfund', 'subO_panic_error_0x41_Block0_2', mstore([num(0x41), mem(0x04)])).
nextlab('crowdfund', 'subO_panic_error_0x41_Block0_2', 'subO_panic_error_0x41_Block0_3').
at('crowdfund', 'subO_panic_error_0x41_Block0_3', revert([num(0x24), mem(0x00)])).
at('crowdfund', 'subO_read_from_storage_split_dynamic_t_uint256_Block0_1', asgn(var(v3), expr(sload([var(v0)])))).
nextlab('crowdfund', 'subO_read_from_storage_split_dynamic_t_uint256_Block0_1', 'subO_read_from_storage_split_dynamic_t_uint256_Block0_2').
at('crowdfund', 'subO_read_from_storage_split_dynamic_t_uint256_Block0_2', fun_call(subO_extract_from_storage_value_dynamict_uint256, [var(v1), var(v3)], [var(v4)])).
nextlab('crowdfund', 'subO_read_from_storage_split_dynamic_t_uint256_Block0_2', 'subO_read_from_storage_split_dynamic_t_uint256_ret').
at('crowdfund', 'subO_read_from_storage_split_dynamic_t_uint256_ret', ret([var(v4)])).
at('crowdfund', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', asgn(var(v2), expr(sload([var(v0)])))).
nextlab('crowdfund', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2').
at('crowdfund', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', fun_call(subO_extract_from_storage_value_offset_0_t_uint256, [var(v2)], [var(v3)])).
nextlab('crowdfund', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', 'subO_read_from_storage_split_offset_0_t_uint256_ret').
at('crowdfund', 'subO_read_from_storage_split_offset_0_t_uint256_ret', ret([var(v3)])).
at('crowdfund', 'subO_require_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('crowdfund', 'subO_require_helper_Block0_1', 'subO_require_helper_Block0_2').
at('crowdfund', 'subO_require_helper_Block0_2', cj(var(v1), 'subO_require_helper_ret', 'subO_require_helper_Block1_1')).
at('crowdfund', 'subO_require_helper_ret', ret([])).
at('crowdfund', 'subO_require_helper_Block1_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('crowdfund', 'subO_round_up_to_mul_of_32_Block0_1', asgn(var(v3), expr(not([num(0x1f)])))).
nextlab('crowdfund', 'subO_round_up_to_mul_of_32_Block0_1', 'subO_round_up_to_mul_of_32_Block0_2').
at('crowdfund', 'subO_round_up_to_mul_of_32_Block0_2', asgn(var(v4), expr(add([num(0x1f), var(v0)])))).
nextlab('crowdfund', 'subO_round_up_to_mul_of_32_Block0_2', 'subO_round_up_to_mul_of_32_Block0_3').
at('crowdfund', 'subO_round_up_to_mul_of_32_Block0_3', asgn(var(v5), expr(and([var(v3), var(v4)])))).
nextlab('crowdfund', 'subO_round_up_to_mul_of_32_Block0_3', 'subO_round_up_to_mul_of_32_ret').
at('crowdfund', 'subO_round_up_to_mul_of_32_ret', ret([var(v5)])).
at('crowdfund', 'subO_shift_left_224_Block0_1', asgn(var(v3), expr(shl([var(v0), num(0xe0)])))).
nextlab('crowdfund', 'subO_shift_left_224_Block0_1', 'subO_shift_left_224_ret').
at('crowdfund', 'subO_shift_left_224_ret', ret([var(v3)])).
at('crowdfund', 'subO_shift_right_0_unsigned_Block0_1', asgn(var(v2), expr(shr([var(v0), num(0x00)])))).
nextlab('crowdfund', 'subO_shift_right_0_unsigned_Block0_1', 'subO_shift_right_0_unsigned_ret').
at('crowdfund', 'subO_shift_right_0_unsigned_ret', ret([var(v2)])).
at('crowdfund', 'subO_shift_right_224_unsigned_Block0_1', asgn(var(v3), expr(shr([var(v0), num(0xe0)])))).
nextlab('crowdfund', 'subO_shift_right_224_unsigned_Block0_1', 'subO_shift_right_224_unsigned_ret').
at('crowdfund', 'subO_shift_right_224_unsigned_ret', ret([var(v3)])).
at('crowdfund', 'subO_shift_right_unsigned_dynamic_Block0_1', asgn(var(v3), expr(shr([var(v1), var(v0)])))).
nextlab('crowdfund', 'subO_shift_right_unsigned_dynamic_Block0_1', 'subO_shift_right_unsigned_dynamic_ret').
at('crowdfund', 'subO_shift_right_unsigned_dynamic_ret', ret([var(v3)])).
at('crowdfund', 'subO_zero_value_for_split_t_bytes_memory_ptr_ret', ret([num(0x60)])).
at('crowdfund', 'start_contract', fun_call(init_contract, [], [])).
nextlab('crowdfund', 'start_contract', 'runtime_contract').
at('crowdfund', 'runtime_contract', fun_call(r_Crowdfund_79_deployed, [], [])).
at('crowdfund', 'init_contract_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('crowdfund', 'init_contract_Block0_1', 'init_contract_Block0_2').
at('crowdfund', 'init_contract_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('crowdfund', 'init_contract_Block0_2', 'init_contract_Block0_3').
at('crowdfund', 'init_contract_Block0_3', asgn(var(v2), expr(callvalue))).
nextlab('crowdfund', 'init_contract_Block0_3', 'init_contract_Block0_4').
at('crowdfund', 'init_contract_Block0_4', cj(var(v2), 'init_contract_Block2_1', 'init_contract_Block1_1')).
at('crowdfund', 'init_contract_Block2_1', fun_call(obj_copy_arguments_for_constructor_24_object_Crowdfund_79, [], [var(v3), var(v4), var(v5), var(v6)])).
nextlab('crowdfund', 'init_contract_Block2_1', 'init_contract_Block2_2').
at('crowdfund', 'init_contract_Block2_2', fun_call(obj_constructor_Crowdfund_79, [var(v6), var(v5), var(v4), var(v3)], [])).
nextlab('crowdfund', 'init_contract_Block2_2', 'init_contract_ret').
at('crowdfund', 'init_contract_ret', ret([])).
at('crowdfund', 'init_contract_Block1_1', fun_call(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block0_1', mstore([num(0x80), mem(0x40)])).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block0_1', 'Crowdfund_79_deployed_Block0_2').
at('crowdfund', 'Crowdfund_79_deployed_Block0_2', asgn(var(v3), expr(calldatasize))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block0_2', 'Crowdfund_79_deployed_Block0_3').
at('crowdfund', 'Crowdfund_79_deployed_Block0_3', asgn(var(v4), expr(lt([num(0x04), var(v3)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block0_3', 'Crowdfund_79_deployed_Block0_4').
at('crowdfund', 'Crowdfund_79_deployed_Block0_4', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block0_4', 'Crowdfund_79_deployed_Block0_5').
at('crowdfund', 'Crowdfund_79_deployed_Block0_5', cj(var(v5), 'Crowdfund_79_deployed_Block2_1', 'Crowdfund_79_deployed_Block1_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block2_1', fun_call(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block1_1', asgn(var(v7), expr(calldataload([num(0x00)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block1_1', 'Crowdfund_79_deployed_Block1_2').
at('crowdfund', 'Crowdfund_79_deployed_Block1_2', fun_call(subO_shift_right_224_unsigned, [var(v7)], [var(v8)])).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block1_2', 'Crowdfund_79_deployed_Block1_3').
at('crowdfund', 'Crowdfund_79_deployed_Block1_3', asgn(var(v9), expr(eq([num(0x3ccfd60b), var(v8)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block1_3', 'Crowdfund_79_deployed_Block1_4').
at('crowdfund', 'Crowdfund_79_deployed_Block1_4', cj(var(v9), 'Crowdfund_79_deployed_Block5_1', 'Crowdfund_79_deployed_Block4_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block5_1', asgn(var(v11), expr(eq([num(0x80e9071b), var(v8)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block5_1', 'Crowdfund_79_deployed_Block5_2').
at('crowdfund', 'Crowdfund_79_deployed_Block5_2', cj(var(v11), 'Crowdfund_79_deployed_Block8_1', 'Crowdfund_79_deployed_Block7_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block4_1', fun_call(subO_external_fun_withdraw_34, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block8_1', asgn(var(v13), expr(eq([num(0xc61b5a59), var(v8)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block8_1', 'Crowdfund_79_deployed_Block8_2').
at('crowdfund', 'Crowdfund_79_deployed_Block8_2', cj(var(v13), 'Crowdfund_79_deployed_Block11_1', 'Crowdfund_79_deployed_Block10_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block7_1', fun_call(subO_external_fun_reclaim_39, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block11_1', asgn(var(v15), expr(eq([num(0xed88c68e), var(v8)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block11_1', 'Crowdfund_79_deployed_Block11_2').
at('crowdfund', 'Crowdfund_79_deployed_Block11_2', cj(var(v15), 'Crowdfund_79_deployed_Block14_1', 'Crowdfund_79_deployed_Block13_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block10_1', fun_call(subO_external_fun__check_invariants_78, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block14_1', asgn(var(v17), expr(eq([num(0xf43cc773), var(v8)])))).
nextlab('crowdfund', 'Crowdfund_79_deployed_Block14_1', 'Crowdfund_79_deployed_Block14_2').
at('crowdfund', 'Crowdfund_79_deployed_Block14_2', cj(var(v17), 'Crowdfund_79_deployed_Block17_1', 'Crowdfund_79_deployed_Block16_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block13_1', fun_call(subO_external_fun_donate_29, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block17_1', goto('Crowdfund_79_deployed_Block3_1')).
at('crowdfund', 'Crowdfund_79_deployed_Block16_1', fun_call(subO_external_fun_totalHeld_9, [], [])).
at('crowdfund', 'Crowdfund_79_deployed_Block3_1', goto('Crowdfund_79_deployed_Block2_1')).

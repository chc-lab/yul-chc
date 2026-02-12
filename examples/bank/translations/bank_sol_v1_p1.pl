address([(0x82dcdd79,'bank')]).

% bank_sol_v1_p1.sol:Bank contract
:- dynamic at/3.
:- discontiguous at/3.
:- discontiguous nextlab/3.
:- discontiguous globals/2.
:- discontiguous signatures/2.
:- discontiguous memory/2.
:- discontiguous fun/5.

signatures('bank', [('external_fun_withdraw_84', '0x2e1a7d4d00000000000000000000000000000000000000000000000000000000'), ('external_fun_deposit_30', '0xd0e30db000000000000000000000000000000000000000000000000000000000')]).

globals('bank', [(address, 0x82dcdd79), 0x00, 0x01]).
memory('bank', [0x00, 0x04, 0x40, 0x80, 0x128, 0xa0, 0xc0, 0xe0]).

fun('bank', obj_allocate_unbounded, [], [var(v2)], 'obj_allocate_unbounded_Block0_1').
fun('bank', obj_cleanup_t_uint160, [var(v0)], [var(v3)], 'obj_cleanup_t_uint160_Block0_1').
fun('bank', obj_constructor_Bank_85, [], [var(v0)], 'obj_constructor_Bank_85_Block0_1').
fun('bank', obj_convert_t_address_to_t_address, [var(v0)], [var(v2)], 'obj_convert_t_address_to_t_address_Block0_1').
fun('bank', obj_convert_t_uint160_to_t_address, [var(v0)], [var(v2)], 'obj_convert_t_uint160_to_t_address_Block0_1').
fun('bank', obj_convert_t_uint160_to_t_uint160, [var(v0)], [var(v3), var(v2), var(v4)], 'obj_convert_t_uint160_to_t_uint160_Block0_1').
fun('bank', obj_identity, [var(v0)], [], 'obj_identity_ret').
fun('bank', obj_prepare_store_t_address, [var(v0)], [], 'obj_prepare_store_t_address_ret').
fun('bank', obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('bank', obj_shift_left_0, [var(v0)], [var(v2)], 'obj_shift_left_0_Block0_1').
fun('bank', obj_update_byte_slice_20_shift_0, [var(v0), var(v1)], [var(v6), var(v5), var(v7), var(v8), var(v4)], 'obj_update_byte_slice_20_shift_0_Block0_1').
fun('bank', obj_update_storage_value_offset_0_t_address_to_t_address, [var(v0), var(v1)], [var(v3), var(v5), var(v2), var(v4)], 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_1').
fun('bank', subO_abi_decode_t_uint256, [var(v0), var(v1)], [var(v3)], 'subO_abi_decode_t_uint256_Block0_1').
fun('bank', subO_abi_decode_tuple_, [var(v0), var(v1)], [var(v3), var(v4)], 'subO_abi_decode_tuple__Block0_1').
fun('bank', subO_abi_decode_tuple_t_uint256, [var(v0), var(v1)], [var(v12), var(v11), var(v5), var(v4)], 'subO_abi_decode_tuple_t_uint256_Block0_1').
fun('bank', subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack, [var(v0)], [var(v3), var(v2)], 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_1').
fun('bank', subO_abi_encode_tuple__to__fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple__to__fromStack_Block0_1').
fun('bank', subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_Block0_1').
fun('bank', subO_allocate_memory, [var(v0)], [var(v2)], 'subO_allocate_memory_Block0_1').
fun('bank', subO_allocate_memory_array_t_bytes_memory_ptr, [var(v0)], [var(v3), var(v2)], 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1').
fun('bank', subO_allocate_unbounded, [], [var(v2)], 'subO_allocate_unbounded_Block0_1').
fun('bank', subO_array_allocation_size_t_bytes_memory_ptr, [var(v0)], [var(v3), var(v9), var(v7)], 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1').
fun('bank', subO_array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack, [var(v0), var(v1)], [], 'subO_array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack_ret').
fun('bank', subO_assert_helper, [var(v0)], [var(v1)], 'subO_assert_helper_Block0_1').
fun('bank', subO_checked_add_t_uint256, [var(v0), var(v1)], [var(v3), var(v6), var(v5), var(v4)], 'subO_checked_add_t_uint256_Block0_1').
fun('bank', subO_checked_sub_t_uint256, [var(v0), var(v1)], [var(v3), var(v6), var(v5), var(v4)], 'subO_checked_sub_t_uint256_Block0_1').
fun('bank', subO_cleanup_from_storage_t_address, [var(v0)], [var(v3)], 'subO_cleanup_from_storage_t_address_Block0_1').
fun('bank', subO_cleanup_from_storage_t_uint256, [var(v0)], [], 'subO_cleanup_from_storage_t_uint256_ret').
fun('bank', subO_cleanup_t_address, [var(v0)], [var(v2)], 'subO_cleanup_t_address_Block0_1').
fun('bank', subO_cleanup_t_rational_0_by_1, [var(v0)], [], 'subO_cleanup_t_rational_0_by_1_ret').
fun('bank', subO_cleanup_t_uint160, [var(v0)], [var(v3)], 'subO_cleanup_t_uint160_Block0_1').
fun('bank', subO_cleanup_t_uint256, [var(v0)], [], 'subO_cleanup_t_uint256_ret').
fun('bank', subO_convert_t_rational_0_by_1_to_t_uint256, [var(v0)], [var(v3), var(v2), var(v4)], 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1').
fun('bank', subO_convert_t_uint256_to_t_uint256, [var(v0)], [var(v3), var(v2), var(v4)], 'subO_convert_t_uint256_to_t_uint256_Block0_1').
fun('bank', subO_external_fun_deposit_30, [], [var(v3), var(v0), var(v2), var(v4)], 'subO_external_fun_deposit_30_Block0_1').
fun('bank', subO_external_fun_withdraw_84, [], [var(v0), var(v1), var(v6), var(v5), var(v3), var(v4)], 'subO_external_fun_withdraw_84_Block0_1').
fun('bank', subO_extract_from_storage_value_offset_0_t_address, [var(v0)], [var(v3), var(v2)], 'subO_extract_from_storage_value_offset_0_t_address_Block0_1').
fun('bank', subO_extract_from_storage_value_offset_0_t_uint256, [var(v0)], [var(v3), var(v2)], 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1').
fun('bank', subO_extract_returndata, [], [var(v2), var(v1), var(v6), var(v9), var(v5), var(v3), var(v8), var(v4)], 'subO_extract_returndata_Block0_1').
fun('bank', subO_finalize_allocation, [var(v0), var(v1)], [var(v2), var(v6), var(v7), var(v3), var(v4)], 'subO_finalize_allocation_Block0_1').
fun('bank', subO_fun_deposit_30, [], [var(v0), var(v2), var(v6), var(v5), var(v7), var(v3), var(v4)], 'subO_fun_deposit_30_Block0_1').
fun('bank', subO_fun_withdraw_84, [var(v0)], [var(v13), var(v15), var(v16), var(v30), var(v5), var(v25), var(v24), var(v4), var(v21), var(v10), var(v26), var(v1), var(v23), var(v3), var(v12), var(v17), var(v22), var(v6), var(v18), var(v27), var(v9), var(v19), var(v29), var(v14), var(v28), var(v20), var(v8), var(v11)], 'subO_fun_withdraw_84_Block0_1').
fun('bank', subO_identity, [var(v0)], [], 'subO_identity_ret').
fun('bank', subO_panic_error_0x01, [], [], 'subO_panic_error_0x01_Block0_1').
fun('bank', subO_panic_error_0x11, [], [], 'subO_panic_error_0x11_Block0_1').
fun('bank', subO_panic_error_0x41, [], [], 'subO_panic_error_0x41_Block0_1').
fun('bank', subO_prepare_store_t_uint256, [var(v0)], [], 'subO_prepare_store_t_uint256_ret').
fun('bank', subO_read_from_storage_split_offset_0_t_address, [var(v0)], [var(v3), var(v2)], 'subO_read_from_storage_split_offset_0_t_address_Block0_1').
fun('bank', subO_read_from_storage_split_offset_0_t_uint256, [var(v0)], [var(v3), var(v2)], 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1').
fun('bank', subO_require_helper, [var(v0)], [var(v1)], 'subO_require_helper_Block0_1').
fun('bank', subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [], 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1').
fun('bank', subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db, [], [], 'subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1').
fun('bank', subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('bank', subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('bank', subO_round_up_to_mul_of_32, [var(v0)], [var(v3), var(v5), var(v4)], 'subO_round_up_to_mul_of_32_Block0_1').
fun('bank', subO_shift_left_0, [var(v0)], [var(v2)], 'subO_shift_left_0_Block0_1').
fun('bank', subO_shift_right_0_unsigned, [var(v0)], [var(v2)], 'subO_shift_right_0_unsigned_Block0_1').
fun('bank', subO_shift_right_224_unsigned, [var(v0)], [var(v3)], 'subO_shift_right_224_unsigned_Block0_1').
fun('bank', subO_store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470, [var(v0)], [], 'subO_store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_ret').
fun('bank', subO_update_byte_slice_32_shift_0, [var(v0), var(v1)], [var(v6), var(v5), var(v7), var(v8), var(v4)], 'subO_update_byte_slice_32_shift_0_Block0_1').
fun('bank', subO_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v0), var(v1)], [var(v3), var(v5), var(v2), var(v4)], 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1').
fun('bank', subO_validator_revert_t_uint256, [var(v0)], [var(v1), var(v3), var(v2)], 'subO_validator_revert_t_uint256_Block0_1').
fun('bank', subO_zero_value_for_split_t_bytes_memory_ptr, [], [], 'subO_zero_value_for_split_t_bytes_memory_ptr_ret').
fun('bank', r_Bank_85_deployed, [], [var(v0), var(v9), var(v5), var(v7), var(v3), var(v11), var(v8), var(v4)], 'Bank_85_deployed_Block0_1').
fun('bank', init_contract, [], [var(v0), var(v2), var(v6), var(v5), var(v3), var(v4)], 'init_contract_Block0_1').

at('bank', 'obj_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('bank', 'obj_allocate_unbounded_Block0_1', 'obj_allocate_unbounded_ret').
at('bank', 'obj_allocate_unbounded_ret', ret([var(v2)])).
at('bank', 'obj_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('bank', 'obj_cleanup_t_uint160_Block0_1', 'obj_cleanup_t_uint160_ret').
at('bank', 'obj_cleanup_t_uint160_ret', ret([var(v3)])).
at('bank', 'obj_constructor_Bank_85_Block0_1', asgn(var(v0), expr(caller))).
nextlab('bank', 'obj_constructor_Bank_85_Block0_1', 'obj_constructor_Bank_85_Block0_2').
at('bank', 'obj_constructor_Bank_85_Block0_2', fun_call(obj_update_storage_value_offset_0_t_address_to_t_address, [var(v0), off(0x01)], [])).
nextlab('bank', 'obj_constructor_Bank_85_Block0_2', 'obj_constructor_Bank_85_ret').
at('bank', 'obj_constructor_Bank_85_ret', ret([])).
at('bank', 'obj_convert_t_address_to_t_address_Block0_1', fun_call(obj_convert_t_uint160_to_t_address, [var(v0)], [var(v2)])).
nextlab('bank', 'obj_convert_t_address_to_t_address_Block0_1', 'obj_convert_t_address_to_t_address_ret').
at('bank', 'obj_convert_t_address_to_t_address_ret', ret([var(v2)])).
at('bank', 'obj_convert_t_uint160_to_t_address_Block0_1', fun_call(obj_convert_t_uint160_to_t_uint160, [var(v0)], [var(v2)])).
nextlab('bank', 'obj_convert_t_uint160_to_t_address_Block0_1', 'obj_convert_t_uint160_to_t_address_ret').
at('bank', 'obj_convert_t_uint160_to_t_address_ret', ret([var(v2)])).
at('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_1', fun_call(obj_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_1', 'obj_convert_t_uint160_to_t_uint160_Block0_2').
at('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_2', fun_call(obj_identity, [var(v2)], [var(v3)])).
nextlab('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_2', 'obj_convert_t_uint160_to_t_uint160_Block0_3').
at('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_3', fun_call(obj_cleanup_t_uint160, [var(v3)], [var(v4)])).
nextlab('bank', 'obj_convert_t_uint160_to_t_uint160_Block0_3', 'obj_convert_t_uint160_to_t_uint160_ret').
at('bank', 'obj_convert_t_uint160_to_t_uint160_ret', ret([var(v4)])).
at('bank', 'obj_identity_ret', ret([var(v0)])).
at('bank', 'obj_prepare_store_t_address_ret', ret([var(v0)])).
at('bank', 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'obj_shift_left_0_Block0_1', asgn(var(v2), expr(shl([var(v0), num(0x00)])))).
nextlab('bank', 'obj_shift_left_0_Block0_1', 'obj_shift_left_0_ret').
at('bank', 'obj_shift_left_0_ret', ret([var(v2)])).
at('bank', 'obj_update_byte_slice_20_shift_0_Block0_1', fun_call(obj_shift_left_0, [var(v1)], [var(v4)])).
nextlab('bank', 'obj_update_byte_slice_20_shift_0_Block0_1', 'obj_update_byte_slice_20_shift_0_Block0_2').
at('bank', 'obj_update_byte_slice_20_shift_0_Block0_2', asgn(var(v5), expr(not([num(0xffffffffffffffffffffffffffffffffffffffff)])))).
nextlab('bank', 'obj_update_byte_slice_20_shift_0_Block0_2', 'obj_update_byte_slice_20_shift_0_Block0_3').
at('bank', 'obj_update_byte_slice_20_shift_0_Block0_3', asgn(var(v6), expr(and([var(v5), var(v0)])))).
nextlab('bank', 'obj_update_byte_slice_20_shift_0_Block0_3', 'obj_update_byte_slice_20_shift_0_Block0_4').
at('bank', 'obj_update_byte_slice_20_shift_0_Block0_4', asgn(var(v7), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v4)])))).
nextlab('bank', 'obj_update_byte_slice_20_shift_0_Block0_4', 'obj_update_byte_slice_20_shift_0_Block0_5').
at('bank', 'obj_update_byte_slice_20_shift_0_Block0_5', asgn(var(v8), expr(or([var(v7), var(v6)])))).
nextlab('bank', 'obj_update_byte_slice_20_shift_0_Block0_5', 'obj_update_byte_slice_20_shift_0_ret').
at('bank', 'obj_update_byte_slice_20_shift_0_ret', ret([var(v8)])).
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_1', fun_call(obj_convert_t_address_to_t_address, [var(v1)], [var(v2)])).
nextlab('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_1', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_2').
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_2', fun_call(obj_prepare_store_t_address, [var(v2)], [var(v3)])).
nextlab('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_2', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_3').
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_3', asgn(var(v4), expr(sload([var(v0)])))).
nextlab('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_3', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_4').
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_4', fun_call(obj_update_byte_slice_20_shift_0, [var(v3), var(v4)], [var(v5)])).
nextlab('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_4', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_5').
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_5', sstore([var(v5), var(v0)])).
nextlab('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_5', 'obj_update_storage_value_offset_0_t_address_to_t_address_ret').
at('bank', 'obj_update_storage_value_offset_0_t_address_to_t_address_ret', ret([])).
at('bank', 'subO_abi_decode_t_uint256_Block0_1', asgn(var(v3), expr(calldataload([var(v0)])))).
nextlab('bank', 'subO_abi_decode_t_uint256_Block0_1', 'subO_abi_decode_t_uint256_Block0_2').
at('bank', 'subO_abi_decode_t_uint256_Block0_2', fun_call(subO_validator_revert_t_uint256, [var(v3)], [])).
nextlab('bank', 'subO_abi_decode_t_uint256_Block0_2', 'subO_abi_decode_t_uint256_ret').
at('bank', 'subO_abi_decode_t_uint256_ret', ret([var(v3)])).
at('bank', 'subO_abi_decode_tuple__Block0_1', asgn(var(v3), expr(sub([var(v0), var(v1)])))).
nextlab('bank', 'subO_abi_decode_tuple__Block0_1', 'subO_abi_decode_tuple__Block0_2').
at('bank', 'subO_abi_decode_tuple__Block0_2', asgn(var(v4), expr(slt([num(0x00), var(v3)])))).
nextlab('bank', 'subO_abi_decode_tuple__Block0_2', 'subO_abi_decode_tuple__Block0_3').
at('bank', 'subO_abi_decode_tuple__Block0_3', cj(var(v4), 'subO_abi_decode_tuple__ret', 'subO_abi_decode_tuple__Block1_1')).
at('bank', 'subO_abi_decode_tuple__ret', ret([])).
at('bank', 'subO_abi_decode_tuple__Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('bank', 'subO_abi_decode_tuple_t_uint256_Block0_1', asgn(var(v4), expr(sub([var(v0), var(v1)])))).
nextlab('bank', 'subO_abi_decode_tuple_t_uint256_Block0_1', 'subO_abi_decode_tuple_t_uint256_Block0_2').
at('bank', 'subO_abi_decode_tuple_t_uint256_Block0_2', asgn(var(v5), expr(slt([num(0x20), var(v4)])))).
nextlab('bank', 'subO_abi_decode_tuple_t_uint256_Block0_2', 'subO_abi_decode_tuple_t_uint256_Block0_3').
at('bank', 'subO_abi_decode_tuple_t_uint256_Block0_3', cj(var(v5), 'subO_abi_decode_tuple_t_uint256_Block2_1', 'subO_abi_decode_tuple_t_uint256_Block1_1')).
at('bank', 'subO_abi_decode_tuple_t_uint256_Block2_1', asgn(var(v11), expr(add([num(0x00), var(v0)])))).
nextlab('bank', 'subO_abi_decode_tuple_t_uint256_Block2_1', 'subO_abi_decode_tuple_t_uint256_Block2_2').
at('bank', 'subO_abi_decode_tuple_t_uint256_Block2_2', fun_call(subO_abi_decode_t_uint256, [var(v1), var(v11)], [var(v12)])).
nextlab('bank', 'subO_abi_decode_tuple_t_uint256_Block2_2', 'subO_abi_decode_tuple_t_uint256_ret').
at('bank', 'subO_abi_decode_tuple_t_uint256_ret', ret([var(v12)])).
at('bank', 'subO_abi_decode_tuple_t_uint256_Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_1', fun_call(subO_array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack, [num(0x00), var(v0)], [var(v2)])).
nextlab('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_1', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_2').
at('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_2', fun_call(subO_store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470, [var(v2)], [])).
nextlab('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_2', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_3').
at('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_3', asgn(var(v3), expr(add([num(0x00), var(v2)])))).
nextlab('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_Block0_3', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_ret').
at('bank', 'subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack_ret', ret([var(v3)])).
at('bank', 'subO_abi_encode_tuple__to__fromStack_Block0_1', asgn(var(v2), expr(add([num(0x00), var(v0)])))).
nextlab('bank', 'subO_abi_encode_tuple__to__fromStack_Block0_1', 'subO_abi_encode_tuple__to__fromStack_ret').
at('bank', 'subO_abi_encode_tuple__to__fromStack_ret', ret([var(v2)])).
at('bank', 'subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_Block0_1', fun_call(subO_abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_Block0_1', 'subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_ret').
at('bank', 'subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_ret', ret([var(v2)])).
at('bank', 'subO_allocate_memory_Block0_1', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('bank', 'subO_allocate_memory_Block0_1', 'subO_allocate_memory_Block0_2').
at('bank', 'subO_allocate_memory_Block0_2', fun_call(subO_finalize_allocation, [var(v0), var(v2)], [])).
nextlab('bank', 'subO_allocate_memory_Block0_2', 'subO_allocate_memory_ret').
at('bank', 'subO_allocate_memory_ret', ret([var(v2)])).
at('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1', fun_call(subO_array_allocation_size_t_bytes_memory_ptr, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_1', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2').
at('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2', fun_call(subO_allocate_memory, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_2', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3').
at('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3', mstore([var(v0), var(v3)])).
nextlab('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_Block0_3', 'subO_allocate_memory_array_t_bytes_memory_ptr_ret').
at('bank', 'subO_allocate_memory_array_t_bytes_memory_ptr_ret', ret([var(v3)])).
at('bank', 'subO_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('bank', 'subO_allocate_unbounded_Block0_1', 'subO_allocate_unbounded_ret').
at('bank', 'subO_allocate_unbounded_ret', ret([var(v2)])).
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1', asgn(var(v3), expr(gt([num(0xffffffffffffffff), var(v0)])))).
nextlab('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_2').
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block0_2', cj(var(v3), 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block1_1')).
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', fun_call(subO_round_up_to_mul_of_32, [var(v0)], [var(v7)])).
nextlab('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_1', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2').
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2', asgn(var(v9), expr(add([num(0x20), var(v7)])))).
nextlab('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block2_2', 'subO_array_allocation_size_t_bytes_memory_ptr_ret').
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_ret', ret([var(v9)])).
at('bank', 'subO_array_allocation_size_t_bytes_memory_ptr_Block1_1', fun_call(subO_panic_error_0x41, [], [])).
at('bank', 'subO_array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack_ret', ret([var(v0)])).
at('bank', 'subO_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('bank', 'subO_assert_helper_Block0_1', 'subO_assert_helper_Block0_2').
at('bank', 'subO_assert_helper_Block0_2', cj(var(v1), 'subO_assert_helper_ret', 'subO_assert_helper_Block1_1')).
at('bank', 'subO_assert_helper_ret', ret([])).
at('bank', 'subO_assert_helper_Block1_1', fun_call(subO_panic_error_0x01, [], [])).
at('bank', 'subO_checked_add_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v3)])).
nextlab('bank', 'subO_checked_add_t_uint256_Block0_1', 'subO_checked_add_t_uint256_Block0_2').
at('bank', 'subO_checked_add_t_uint256_Block0_2', fun_call(subO_cleanup_t_uint256, [var(v1)], [var(v4)])).
nextlab('bank', 'subO_checked_add_t_uint256_Block0_2', 'subO_checked_add_t_uint256_Block0_3').
at('bank', 'subO_checked_add_t_uint256_Block0_3', asgn(var(v5), expr(add([var(v4), var(v3)])))).
nextlab('bank', 'subO_checked_add_t_uint256_Block0_3', 'subO_checked_add_t_uint256_Block0_4').
at('bank', 'subO_checked_add_t_uint256_Block0_4', asgn(var(v6), expr(gt([var(v5), var(v3)])))).
nextlab('bank', 'subO_checked_add_t_uint256_Block0_4', 'subO_checked_add_t_uint256_Block0_5').
at('bank', 'subO_checked_add_t_uint256_Block0_5', cj(var(v6), 'subO_checked_add_t_uint256_ret', 'subO_checked_add_t_uint256_Block1_1')).
at('bank', 'subO_checked_add_t_uint256_ret', ret([var(v5)])).
at('bank', 'subO_checked_add_t_uint256_Block1_1', fun_call(subO_panic_error_0x11, [], [])).
at('bank', 'subO_checked_sub_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v3)])).
nextlab('bank', 'subO_checked_sub_t_uint256_Block0_1', 'subO_checked_sub_t_uint256_Block0_2').
at('bank', 'subO_checked_sub_t_uint256_Block0_2', fun_call(subO_cleanup_t_uint256, [var(v1)], [var(v4)])).
nextlab('bank', 'subO_checked_sub_t_uint256_Block0_2', 'subO_checked_sub_t_uint256_Block0_3').
at('bank', 'subO_checked_sub_t_uint256_Block0_3', asgn(var(v5), expr(sub([var(v4), var(v3)])))).
nextlab('bank', 'subO_checked_sub_t_uint256_Block0_3', 'subO_checked_sub_t_uint256_Block0_4').
at('bank', 'subO_checked_sub_t_uint256_Block0_4', asgn(var(v6), expr(gt([var(v3), var(v5)])))).
nextlab('bank', 'subO_checked_sub_t_uint256_Block0_4', 'subO_checked_sub_t_uint256_Block0_5').
at('bank', 'subO_checked_sub_t_uint256_Block0_5', cj(var(v6), 'subO_checked_sub_t_uint256_ret', 'subO_checked_sub_t_uint256_Block1_1')).
at('bank', 'subO_checked_sub_t_uint256_ret', ret([var(v5)])).
at('bank', 'subO_checked_sub_t_uint256_Block1_1', fun_call(subO_panic_error_0x11, [], [])).
at('bank', 'subO_cleanup_from_storage_t_address_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('bank', 'subO_cleanup_from_storage_t_address_Block0_1', 'subO_cleanup_from_storage_t_address_ret').
at('bank', 'subO_cleanup_from_storage_t_address_ret', ret([var(v3)])).
at('bank', 'subO_cleanup_from_storage_t_uint256_ret', ret([var(v0)])).
at('bank', 'subO_cleanup_t_address_Block0_1', fun_call(subO_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_cleanup_t_address_Block0_1', 'subO_cleanup_t_address_ret').
at('bank', 'subO_cleanup_t_address_ret', ret([var(v2)])).
at('bank', 'subO_cleanup_t_rational_0_by_1_ret', ret([var(v0)])).
at('bank', 'subO_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('bank', 'subO_cleanup_t_uint160_Block0_1', 'subO_cleanup_t_uint160_ret').
at('bank', 'subO_cleanup_t_uint160_ret', ret([var(v3)])).
at('bank', 'subO_cleanup_t_uint256_ret', ret([var(v0)])).
at('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1', fun_call(subO_cleanup_t_rational_0_by_1, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_1', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2').
at('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_2', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3').
at('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_Block0_3', 'subO_convert_t_rational_0_by_1_to_t_uint256_ret').
at('bank', 'subO_convert_t_rational_0_by_1_to_t_uint256_ret', ret([var(v4)])).
at('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_1', 'subO_convert_t_uint256_to_t_uint256_Block0_2').
at('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_2', 'subO_convert_t_uint256_to_t_uint256_Block0_3').
at('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('bank', 'subO_convert_t_uint256_to_t_uint256_Block0_3', 'subO_convert_t_uint256_to_t_uint256_ret').
at('bank', 'subO_convert_t_uint256_to_t_uint256_ret', ret([var(v4)])).
at('bank', 'subO_external_fun_deposit_30_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_1', 'subO_external_fun_deposit_30_Block0_2').
at('bank', 'subO_external_fun_deposit_30_Block0_2', fun_call(subO_abi_decode_tuple_, [var(v0), num(0x04)], [])).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_2', 'subO_external_fun_deposit_30_Block0_3').
at('bank', 'subO_external_fun_deposit_30_Block0_3', fun_call(subO_fun_deposit_30, [], [])).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_3', 'subO_external_fun_deposit_30_Block0_4').
at('bank', 'subO_external_fun_deposit_30_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_4', 'subO_external_fun_deposit_30_Block0_5').
at('bank', 'subO_external_fun_deposit_30_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_5', 'subO_external_fun_deposit_30_Block0_6').
at('bank', 'subO_external_fun_deposit_30_Block0_6', asgn(var(v4), expr(sub([var(v2), var(v3)])))).
nextlab('bank', 'subO_external_fun_deposit_30_Block0_6', 'subO_external_fun_deposit_30_Block0_7').
at('bank', 'subO_external_fun_deposit_30_Block0_7', return([var(v4), var(v2)])).
at('bank', 'subO_external_fun_withdraw_84_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('bank', 'subO_external_fun_withdraw_84_Block0_1', 'subO_external_fun_withdraw_84_Block0_2').
at('bank', 'subO_external_fun_withdraw_84_Block0_2', cj(var(v0), 'subO_external_fun_withdraw_84_Block2_1', 'subO_external_fun_withdraw_84_Block1_1')).
at('bank', 'subO_external_fun_withdraw_84_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_1', 'subO_external_fun_withdraw_84_Block2_2').
at('bank', 'subO_external_fun_withdraw_84_Block2_2', fun_call(subO_abi_decode_tuple_t_uint256, [var(v1), num(0x04)], [var(v3)])).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_2', 'subO_external_fun_withdraw_84_Block2_3').


at('bank', 'subO_external_fun_withdraw_84_Block2_3', fun_call(subO_fun_withdraw_84, [var(v3)], [])).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_3', 'subO_external_fun_withdraw_84_Block2_4').
at('bank', 'subO_external_fun_withdraw_84_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v4)])).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_4', 'subO_external_fun_withdraw_84_Block2_5').


at('bank', 'subO_external_fun_withdraw_84_Block2_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v4)], [var(v5)])).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_5', 'subO_external_fun_withdraw_84_Block2_6').
at('bank', 'subO_external_fun_withdraw_84_Block2_6', asgn(var(v6), expr(sub([var(v4), var(v5)])))).
nextlab('bank', 'subO_external_fun_withdraw_84_Block2_6', 'subO_external_fun_withdraw_84_Block2_7').
at('bank', 'subO_external_fun_withdraw_84_Block2_7', return([var(v6), var(v4)])).
at('bank', 'subO_external_fun_withdraw_84_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('bank', 'subO_extract_from_storage_value_offset_0_t_address_Block0_1', fun_call(subO_shift_right_0_unsigned, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_extract_from_storage_value_offset_0_t_address_Block0_1', 'subO_extract_from_storage_value_offset_0_t_address_Block0_2').
at('bank', 'subO_extract_from_storage_value_offset_0_t_address_Block0_2', fun_call(subO_cleanup_from_storage_t_address, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_extract_from_storage_value_offset_0_t_address_Block0_2', 'subO_extract_from_storage_value_offset_0_t_address_ret').
at('bank', 'subO_extract_from_storage_value_offset_0_t_address_ret', ret([var(v3)])).
at('bank', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', fun_call(subO_shift_right_0_unsigned, [var(v0)], [var(v2)])).
nextlab('bank', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2').
at('bank', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', fun_call(subO_cleanup_from_storage_t_uint256, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_2', 'subO_extract_from_storage_value_offset_0_t_uint256_ret').
at('bank', 'subO_extract_from_storage_value_offset_0_t_uint256_ret', ret([var(v3)])).
at('bank', 'subO_extract_returndata_Block0_1', asgn(var(v1), expr(returndatasize))).
nextlab('bank', 'subO_extract_returndata_Block0_1', 'subO_extract_returndata_Block0_2').
at('bank', 'subO_extract_returndata_Block0_2', asgn(var(v2), expr(eq([num(0x00), var(v1)])))).
nextlab('bank', 'subO_extract_returndata_Block0_2', 'subO_extract_returndata_Block0_3').
at('bank', 'subO_extract_returndata_Block0_3', cj(var(v2), 'subO_extract_returndata_Block3_1', 'subO_extract_returndata_Block2_1')).
at('bank', 'subO_extract_returndata_Block3_1', asgn(var(v4), expr(returndatasize))).
nextlab('bank', 'subO_extract_returndata_Block3_1', 'subO_extract_returndata_Block3_2').
at('bank', 'subO_extract_returndata_Block3_2', fun_call(subO_allocate_memory_array_t_bytes_memory_ptr, [var(v4)], [var(v5)])).
nextlab('bank', 'subO_extract_returndata_Block3_2', 'subO_extract_returndata_Block3_3').
at('bank', 'subO_extract_returndata_Block3_3', asgn(var(v6), expr(returndatasize))).
nextlab('bank', 'subO_extract_returndata_Block3_3', 'subO_extract_returndata_Block3_4').
at('bank', 'subO_extract_returndata_Block3_4', asgn(var(v8), expr(add([num(0x20), var(v5)])))).
nextlab('bank', 'subO_extract_returndata_Block3_4', 'subO_extract_returndata_Block3_5').
at('bank', 'subO_extract_returndata_Block3_5', returndatacopy([var(v6), num(0x00), var(v8)])).
nextlab('bank', 'subO_extract_returndata_Block3_5', 'subO_extract_returndata_Block3_6').
at('bank', 'subO_extract_returndata_Block3_6', goto('subO_extract_returndata_Block1_1_2')).
at('bank', 'subO_extract_returndata_Block2_1', fun_call(subO_zero_value_for_split_t_bytes_memory_ptr, [], [var(v3)])).
nextlab('bank', 'subO_extract_returndata_Block2_1', 'subO_extract_returndata_Block2_2').
at('bank', 'subO_extract_returndata_Block2_2', goto('subO_extract_returndata_Block1_1_1')).
at('bank', 'subO_extract_returndata_Block1_1_1', asgn(var(v9), expr(phiFunction([var(v3)])))).
nextlab('bank', 'subO_extract_returndata_Block1_1_1', 'subO_extract_returndata_ret').
at('bank', 'subO_extract_returndata_Block1_1_2', asgn(var(v9), expr(phiFunction([var(v5)])))).
nextlab('bank', 'subO_extract_returndata_Block1_1_2', 'subO_extract_returndata_ret').
at('bank', 'subO_extract_returndata_ret', ret([var(v9)])).
at('bank', 'subO_finalize_allocation_Block0_1', fun_call(subO_round_up_to_mul_of_32, [var(v1)], [var(v2)])).
nextlab('bank', 'subO_finalize_allocation_Block0_1', 'subO_finalize_allocation_Block0_2').
at('bank', 'subO_finalize_allocation_Block0_2', asgn(var(v3), expr(add([var(v2), var(v0)])))).
nextlab('bank', 'subO_finalize_allocation_Block0_2', 'subO_finalize_allocation_Block0_3').
at('bank', 'subO_finalize_allocation_Block0_3', asgn(var(v4), expr(lt([var(v0), var(v3)])))).
nextlab('bank', 'subO_finalize_allocation_Block0_3', 'subO_finalize_allocation_Block0_4').
at('bank', 'subO_finalize_allocation_Block0_4', asgn(var(v6), expr(gt([num(0xffffffffffffffff), var(v3)])))).
nextlab('bank', 'subO_finalize_allocation_Block0_4', 'subO_finalize_allocation_Block0_5').
at('bank', 'subO_finalize_allocation_Block0_5', asgn(var(v7), expr(or([var(v4), var(v6)])))).
nextlab('bank', 'subO_finalize_allocation_Block0_5', 'subO_finalize_allocation_Block0_6').
at('bank', 'subO_finalize_allocation_Block0_6', cj(var(v7), 'subO_finalize_allocation_Block2_1', 'subO_finalize_allocation_Block1_1')).
at('bank', 'subO_finalize_allocation_Block2_1', mstore([var(v3), mem(0x40)])).
nextlab('bank', 'subO_finalize_allocation_Block2_1', 'subO_finalize_allocation_ret').
at('bank', 'subO_finalize_allocation_ret', ret([])).
at('bank', 'subO_finalize_allocation_Block1_1', fun_call(subO_panic_error_0x41, [], [])).
at('bank', 'subO_fun_deposit_30_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('bank', 'subO_fun_deposit_30_Block0_1', 'subO_fun_deposit_30_Block0_2').
at('bank', 'subO_fun_deposit_30_Block0_2', fun_call(subO_convert_t_rational_0_by_1_to_t_uint256, [num(0x00)], [var(v2)])).
nextlab('bank', 'subO_fun_deposit_30_Block0_2', 'subO_fun_deposit_30_Block0_3').
at('bank', 'subO_fun_deposit_30_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v3)])).
nextlab('bank', 'subO_fun_deposit_30_Block0_3', 'subO_fun_deposit_30_Block0_4').
at('bank', 'subO_fun_deposit_30_Block0_4', asgn(var(v4), expr(gt([var(v2), var(v3)])))).
nextlab('bank', 'subO_fun_deposit_30_Block0_4', 'subO_fun_deposit_30_Block0_5').
at('bank', 'subO_fun_deposit_30_Block0_5', fun_call(subO_require_helper, [var(v4)], [])).
nextlab('bank', 'subO_fun_deposit_30_Block0_5', 'subO_fun_deposit_30_Block0_6').
at('bank', 'subO_fun_deposit_30_Block0_6', asgn(var(v5), expr(callvalue))).
nextlab('bank', 'subO_fun_deposit_30_Block0_6', 'subO_fun_deposit_30_Block0_7').
at('bank', 'subO_fun_deposit_30_Block0_7', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v6)])).
nextlab('bank', 'subO_fun_deposit_30_Block0_7', 'subO_fun_deposit_30_Block0_8').
at('bank', 'subO_fun_deposit_30_Block0_8', fun_call(subO_checked_add_t_uint256, [var(v5), var(v6)], [var(v7)])).
nextlab('bank', 'subO_fun_deposit_30_Block0_8', 'subO_fun_deposit_30_Block0_9').
at('bank', 'subO_fun_deposit_30_Block0_9', fun_call(subO_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v7), off(0x00)], [])).
nextlab('bank', 'subO_fun_deposit_30_Block0_9', 'subO_fun_deposit_30_ret').
at('bank', 'subO_fun_deposit_30_ret', ret([])).



at('bank', 'subO_fun_withdraw_84_Block0_1', asgn(var(v1), expr(caller))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_1', 'subO_fun_withdraw_84_Block0_2').
at('bank', 'subO_fun_withdraw_84_Block0_2', fun_call(subO_read_from_storage_split_offset_0_t_address, [off(0x01)], [var(v3)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_2', 'subO_fun_withdraw_84_Block0_3').
at('bank', 'subO_fun_withdraw_84_Block0_3', fun_call(subO_cleanup_t_address, [var(v3)], [var(v4)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_3', 'subO_fun_withdraw_84_Block0_4').
at('bank', 'subO_fun_withdraw_84_Block0_4', fun_call(subO_cleanup_t_address, [var(v1)], [var(v5)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_4', 'subO_fun_withdraw_84_Block0_5').
at('bank', 'subO_fun_withdraw_84_Block0_5', asgn(var(v6), expr(eq([var(v4), var(v5)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_5', 'subO_fun_withdraw_84_Block0_6').
at('bank', 'subO_fun_withdraw_84_Block0_6', fun_call(subO_require_helper, [var(v6)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_6', 'subO_fun_withdraw_84_Block0_7').
at('bank', 'subO_fun_withdraw_84_Block0_7', fun_call(subO_convert_t_rational_0_by_1_to_t_uint256, [num(0x00)], [var(v8)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_7', 'subO_fun_withdraw_84_Block0_8').
at('bank', 'subO_fun_withdraw_84_Block0_8', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v9)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_8', 'subO_fun_withdraw_84_Block0_9').
at('bank', 'subO_fun_withdraw_84_Block0_9', asgn(var(v10), expr(gt([var(v8), var(v9)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_9', 'subO_fun_withdraw_84_Block0_10').
at('bank', 'subO_fun_withdraw_84_Block0_10', fun_call(subO_require_helper, [var(v10)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_10', 'subO_fun_withdraw_84_Block0_11').
at('bank', 'subO_fun_withdraw_84_Block0_11', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v11)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_11', 'subO_fun_withdraw_84_Block0_12').
at('bank', 'subO_fun_withdraw_84_Block0_12', fun_call(subO_cleanup_t_uint256, [var(v11)], [var(v12)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_12', 'subO_fun_withdraw_84_Block0_13').
at('bank', 'subO_fun_withdraw_84_Block0_13', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v13)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_13', 'subO_fun_withdraw_84_Block0_14').
at('bank', 'subO_fun_withdraw_84_Block0_14', asgn(var(v14), expr(gt([var(v12), var(v13)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_14', 'subO_fun_withdraw_84_Block0_15').
at('bank', 'subO_fun_withdraw_84_Block0_15', asgn(var(v15), expr(iszero([var(v14)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_15', 'subO_fun_withdraw_84_Block0_16').
at('bank', 'subO_fun_withdraw_84_Block0_16', fun_call(subO_require_helper, [var(v15)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_16', 'subO_fun_withdraw_84_Block0_17').
at('bank', 'subO_fun_withdraw_84_Block0_17', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v16)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_17', 'subO_fun_withdraw_84_Block0_18').
at('bank', 'subO_fun_withdraw_84_Block0_18', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v17)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_18', 'subO_fun_withdraw_84_Block0_19').
at('bank', 'subO_fun_withdraw_84_Block0_19', fun_call(subO_checked_sub_t_uint256, [var(v0), var(v17)], [var(v18)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_19', 'subO_fun_withdraw_84_Block0_20').
at('bank', 'subO_fun_withdraw_84_Block0_20', fun_call(subO_update_storage_value_offset_0_t_uint256_to_t_uint256, [var(v18), off(0x00)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_20', 'subO_fun_withdraw_84_Block0_21').
at('bank', 'subO_fun_withdraw_84_Block0_21', fun_call(subO_read_from_storage_split_offset_0_t_address, [off(0x01)], [var(v19)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_21', 'subO_fun_withdraw_84_Block0_22').
at('bank', 'subO_fun_withdraw_84_Block0_22', fun_call(subO_allocate_unbounded, [], [var(v20)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_22', 'subO_fun_withdraw_84_Block0_23').
at('bank', 'subO_fun_withdraw_84_Block0_23', fun_call(subO_abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack, [var(v20)], [var(v21)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_23', 'subO_fun_withdraw_84_Block0_24').
at('bank', 'subO_fun_withdraw_84_Block0_24', asgn(var(v22), expr(sub([var(v20), var(v21)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_24', 'subO_fun_withdraw_84_Block0_25').
at('bank', 'subO_fun_withdraw_84_Block0_25', asgn(var(v23), expr(gas))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_25', 'subO_fun_withdraw_84_Block0_26').
at('bank', 'subO_fun_withdraw_84_Block0_26', call([num(0x00), num(0x00), var(v22), var(v20), var(v0), var(v19), var(v23)], var(v24))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_26', 'subO_fun_withdraw_84_Block0_27').
at('bank', 'subO_fun_withdraw_84_Block0_27', fun_call(subO_extract_returndata, [], [var(v25)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_27', 'subO_fun_withdraw_84_Block0_28').
at('bank', 'subO_fun_withdraw_84_Block0_28', fun_call(subO_require_helper, [var(v24)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_28', 'subO_fun_withdraw_84_Block0_29').
at('bank', 'subO_fun_withdraw_84_Block0_29', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v26)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_29', 'subO_fun_withdraw_84_Block0_30').
at('bank', 'subO_fun_withdraw_84_Block0_30', fun_call(subO_checked_sub_t_uint256, [var(v0), var(v16)], [var(v27)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_30', 'subO_fun_withdraw_84_Block0_31').
at('bank', 'subO_fun_withdraw_84_Block0_31', fun_call(subO_cleanup_t_uint256, [var(v27)], [var(v28)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_31', 'subO_fun_withdraw_84_Block0_32').
at('bank', 'subO_fun_withdraw_84_Block0_32', fun_call(subO_cleanup_t_uint256, [var(v26)], [var(v29)])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_32', 'subO_fun_withdraw_84_Block0_33').
at('bank', 'subO_fun_withdraw_84_Block0_33', asgn(var(v30), expr(eq([var(v28), var(v29)])))).
nextlab('bank', 'subO_fun_withdraw_84_Block0_33', 'subO_fun_withdraw_84_Block0_34').
at('bank', 'subO_fun_withdraw_84_Block0_34', fun_call(subO_assert_helper, [var(v30)], [])).
nextlab('bank', 'subO_fun_withdraw_84_Block0_34', 'subO_fun_withdraw_84_ret').
at('bank', 'subO_fun_withdraw_84_ret', ret([])).


at('bank', 'subO_identity_ret', ret([var(v0)])).
at('bank', 'subO_panic_error_0x01_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('bank', 'subO_panic_error_0x01_Block0_1', 'subO_panic_error_0x01_Block0_2').
at('bank', 'subO_panic_error_0x01_Block0_2', mstore([num(0x01), mem(0x04)])).
nextlab('bank', 'subO_panic_error_0x01_Block0_2', 'subO_panic_error_0x01_Block0_3').
at('bank', 'subO_panic_error_0x01_Block0_3', revert([num(0x24), mem(0x00)])).
at('bank', 'subO_panic_error_0x11_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('bank', 'subO_panic_error_0x11_Block0_1', 'subO_panic_error_0x11_Block0_2').
at('bank', 'subO_panic_error_0x11_Block0_2', mstore([num(0x11), mem(0x04)])).
nextlab('bank', 'subO_panic_error_0x11_Block0_2', 'subO_panic_error_0x11_Block0_3').
at('bank', 'subO_panic_error_0x11_Block0_3', revert([num(0x24), mem(0x00)])).
at('bank', 'subO_panic_error_0x41_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('bank', 'subO_panic_error_0x41_Block0_1', 'subO_panic_error_0x41_Block0_2').
at('bank', 'subO_panic_error_0x41_Block0_2', mstore([num(0x41), mem(0x04)])).
nextlab('bank', 'subO_panic_error_0x41_Block0_2', 'subO_panic_error_0x41_Block0_3').
at('bank', 'subO_panic_error_0x41_Block0_3', revert([num(0x24), mem(0x00)])).
at('bank', 'subO_prepare_store_t_uint256_ret', ret([var(v0)])).
at('bank', 'subO_read_from_storage_split_offset_0_t_address_Block0_1', asgn(var(v2), expr(sload([var(v0)])))).
nextlab('bank', 'subO_read_from_storage_split_offset_0_t_address_Block0_1', 'subO_read_from_storage_split_offset_0_t_address_Block0_2').
at('bank', 'subO_read_from_storage_split_offset_0_t_address_Block0_2', fun_call(subO_extract_from_storage_value_offset_0_t_address, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_read_from_storage_split_offset_0_t_address_Block0_2', 'subO_read_from_storage_split_offset_0_t_address_ret').
at('bank', 'subO_read_from_storage_split_offset_0_t_address_ret', ret([var(v3)])).
at('bank', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', asgn(var(v2), expr(sload([var(v0)])))).
nextlab('bank', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2').
at('bank', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', fun_call(subO_extract_from_storage_value_offset_0_t_uint256, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_read_from_storage_split_offset_0_t_uint256_Block0_2', 'subO_read_from_storage_split_offset_0_t_uint256_ret').
at('bank', 'subO_read_from_storage_split_offset_0_t_uint256_ret', ret([var(v3)])).
at('bank', 'subO_require_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('bank', 'subO_require_helper_Block0_1', 'subO_require_helper_Block0_2').
at('bank', 'subO_require_helper_Block0_2', cj(var(v1), 'subO_require_helper_ret', 'subO_require_helper_Block1_1')).
at('bank', 'subO_require_helper_ret', ret([])).
at('bank', 'subO_require_helper_Block1_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_round_up_to_mul_of_32_Block0_1', asgn(var(v3), expr(not([num(0x1f)])))).
nextlab('bank', 'subO_round_up_to_mul_of_32_Block0_1', 'subO_round_up_to_mul_of_32_Block0_2').
at('bank', 'subO_round_up_to_mul_of_32_Block0_2', asgn(var(v4), expr(add([num(0x1f), var(v0)])))).
nextlab('bank', 'subO_round_up_to_mul_of_32_Block0_2', 'subO_round_up_to_mul_of_32_Block0_3').
at('bank', 'subO_round_up_to_mul_of_32_Block0_3', asgn(var(v5), expr(and([var(v3), var(v4)])))).
nextlab('bank', 'subO_round_up_to_mul_of_32_Block0_3', 'subO_round_up_to_mul_of_32_ret').
at('bank', 'subO_round_up_to_mul_of_32_ret', ret([var(v5)])).
at('bank', 'subO_shift_left_0_Block0_1', asgn(var(v2), expr(shl([var(v0), num(0x00)])))).
nextlab('bank', 'subO_shift_left_0_Block0_1', 'subO_shift_left_0_ret').
at('bank', 'subO_shift_left_0_ret', ret([var(v2)])).
at('bank', 'subO_shift_right_0_unsigned_Block0_1', asgn(var(v2), expr(shr([var(v0), num(0x00)])))).
nextlab('bank', 'subO_shift_right_0_unsigned_Block0_1', 'subO_shift_right_0_unsigned_ret').
at('bank', 'subO_shift_right_0_unsigned_ret', ret([var(v2)])).
at('bank', 'subO_shift_right_224_unsigned_Block0_1', asgn(var(v3), expr(shr([var(v0), num(0xe0)])))).
nextlab('bank', 'subO_shift_right_224_unsigned_Block0_1', 'subO_shift_right_224_unsigned_ret').
at('bank', 'subO_shift_right_224_unsigned_ret', ret([var(v3)])).
at('bank', 'subO_store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_ret', ret([])).
at('bank', 'subO_update_byte_slice_32_shift_0_Block0_1', fun_call(subO_shift_left_0, [var(v1)], [var(v4)])).
nextlab('bank', 'subO_update_byte_slice_32_shift_0_Block0_1', 'subO_update_byte_slice_32_shift_0_Block0_2').
at('bank', 'subO_update_byte_slice_32_shift_0_Block0_2', asgn(var(v5), expr(not([num(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)])))).
nextlab('bank', 'subO_update_byte_slice_32_shift_0_Block0_2', 'subO_update_byte_slice_32_shift_0_Block0_3').
at('bank', 'subO_update_byte_slice_32_shift_0_Block0_3', asgn(var(v6), expr(and([var(v5), var(v0)])))).
nextlab('bank', 'subO_update_byte_slice_32_shift_0_Block0_3', 'subO_update_byte_slice_32_shift_0_Block0_4').
at('bank', 'subO_update_byte_slice_32_shift_0_Block0_4', asgn(var(v7), expr(and([num(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), var(v4)])))).
nextlab('bank', 'subO_update_byte_slice_32_shift_0_Block0_4', 'subO_update_byte_slice_32_shift_0_Block0_5').
at('bank', 'subO_update_byte_slice_32_shift_0_Block0_5', asgn(var(v8), expr(or([var(v7), var(v6)])))).
nextlab('bank', 'subO_update_byte_slice_32_shift_0_Block0_5', 'subO_update_byte_slice_32_shift_0_ret').
at('bank', 'subO_update_byte_slice_32_shift_0_ret', ret([var(v8)])).
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1', fun_call(subO_convert_t_uint256_to_t_uint256, [var(v1)], [var(v2)])).
nextlab('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_1', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2').
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2', fun_call(subO_prepare_store_t_uint256, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_2', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3').
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3', asgn(var(v4), expr(sload([var(v0)])))).
nextlab('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_3', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4').
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4', fun_call(subO_update_byte_slice_32_shift_0, [var(v3), var(v4)], [var(v5)])).
nextlab('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_4', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5').
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5', sstore([var(v5), var(v0)])).
nextlab('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_Block0_5', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_ret').
at('bank', 'subO_update_storage_value_offset_0_t_uint256_to_t_uint256_ret', ret([])).
at('bank', 'subO_validator_revert_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v1)])).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_1', 'subO_validator_revert_t_uint256_Block0_2').
at('bank', 'subO_validator_revert_t_uint256_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_2', 'subO_validator_revert_t_uint256_Block0_3').
at('bank', 'subO_validator_revert_t_uint256_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_3', 'subO_validator_revert_t_uint256_Block0_4').
at('bank', 'subO_validator_revert_t_uint256_Block0_4', cj(var(v3), 'subO_validator_revert_t_uint256_ret', 'subO_validator_revert_t_uint256_Block1_1')).
at('bank', 'subO_validator_revert_t_uint256_ret', ret([])).
at('bank', 'subO_validator_revert_t_uint256_Block1_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_zero_value_for_split_t_bytes_memory_ptr_ret', ret([num(0x60)])).
at('bank', 'start_contract', fun_call(init_contract, [], [])).
nextlab('bank', 'start_contract', 'runtime_contract').
at('bank', 'runtime_contract', fun_call(r_Bank_85_deployed, [], [])).
at('bank', 'init_contract_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('bank', 'init_contract_Block0_1', 'init_contract_Block0_2').
at('bank', 'init_contract_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('bank', 'init_contract_Block0_2', 'init_contract_Block0_3').
at('bank', 'init_contract_Block0_3', asgn(var(v2), expr(callvalue))).
nextlab('bank', 'init_contract_Block0_3', 'init_contract_Block0_4').
at('bank', 'init_contract_Block0_4', cj(var(v2), 'init_contract_Block2_1', 'init_contract_Block1_1')).
at('bank', 'init_contract_Block2_1', fun_call(obj_constructor_Bank_85, [], [])).
nextlab('bank', 'init_contract_Block2_1', 'init_contract_ret').
at('bank', 'init_contract_ret', ret([])).
at('bank', 'init_contract_Block1_1', fun_call(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('bank', 'Bank_85_deployed_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('bank', 'Bank_85_deployed_Block0_1', 'Bank_85_deployed_Block0_2').
at('bank', 'Bank_85_deployed_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('bank', 'Bank_85_deployed_Block0_2', 'Bank_85_deployed_Block0_3').
at('bank', 'Bank_85_deployed_Block0_3', asgn(var(v3), expr(calldatasize))).
nextlab('bank', 'Bank_85_deployed_Block0_3', 'Bank_85_deployed_Block0_4').
at('bank', 'Bank_85_deployed_Block0_4', asgn(var(v4), expr(lt([num(0x04), var(v3)])))).
nextlab('bank', 'Bank_85_deployed_Block0_4', 'Bank_85_deployed_Block0_5').
at('bank', 'Bank_85_deployed_Block0_5', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('bank', 'Bank_85_deployed_Block0_5', 'Bank_85_deployed_Block0_6').
at('bank', 'Bank_85_deployed_Block0_6', cj(var(v5), 'Bank_85_deployed_Block2_1', 'Bank_85_deployed_Block1_1')).
at('bank', 'Bank_85_deployed_Block2_1', fun_call(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [])).
at('bank', 'Bank_85_deployed_Block1_1', asgn(var(v7), expr(calldataload([num(0x00)])))).
nextlab('bank', 'Bank_85_deployed_Block1_1', 'Bank_85_deployed_Block1_2').
at('bank', 'Bank_85_deployed_Block1_2', fun_call(subO_shift_right_224_unsigned, [var(v7)], [var(v8)])).
nextlab('bank', 'Bank_85_deployed_Block1_2', 'Bank_85_deployed_Block1_3').
at('bank', 'Bank_85_deployed_Block1_3', asgn(var(v9), expr(eq([num(0x2e1a7d4d), var(v8)])))).
nextlab('bank', 'Bank_85_deployed_Block1_3', 'Bank_85_deployed_Block1_4').
at('bank', 'Bank_85_deployed_Block1_4', cj(var(v9), 'Bank_85_deployed_Block5_1', 'Bank_85_deployed_Block4_1')).
at('bank', 'Bank_85_deployed_Block5_1', asgn(var(v11), expr(eq([num(0xd0e30db0), var(v8)])))).
nextlab('bank', 'Bank_85_deployed_Block5_1', 'Bank_85_deployed_Block5_2').
at('bank', 'Bank_85_deployed_Block5_2', cj(var(v11), 'Bank_85_deployed_Block8_1', 'Bank_85_deployed_Block7_1')).
at('bank', 'Bank_85_deployed_Block4_1', fun_call(subO_external_fun_withdraw_84, [], [])).
at('bank', 'Bank_85_deployed_Block8_1', goto('Bank_85_deployed_Block3_1')).
at('bank', 'Bank_85_deployed_Block7_1', fun_call(subO_external_fun_deposit_30, [], [])).
at('bank', 'Bank_85_deployed_Block3_1', goto('Bank_85_deployed_Block2_1')).
address([(0x876da654,'bank')]).

% bank_yul_v1_p1.sol:Bank contract
:- dynamic at/3.
:- discontiguous at/3.
:- discontiguous nextlab/3.
:- discontiguous globals/2.
:- discontiguous signatures/2.
:- discontiguous memory/2.
:- discontiguous fun/5.

signatures('bank', [('external_fun_withdraw_42', '0x2e1a7d4d00000000000000000000000000000000000000000000000000000000'), ('external_fun_deposit_19', '0xd0e30db000000000000000000000000000000000000000000000000000000000')]).

globals('bank', [(address, 0x876da654), 0x00, 0x01]).
memory('bank', [0x00, 0x04, 0x40, 0x80, 0x128, 0xa0, 0xc0, 0xe0]).

fun('bank', obj_allocate_unbounded, [], [var(v2)], 'obj_allocate_unbounded_Block0_1').
fun('bank', obj_cleanup_t_uint160, [var(v0)], [var(v3)], 'obj_cleanup_t_uint160_Block0_1').
fun('bank', obj_constructor_Bank_43, [], [var(v0)], 'obj_constructor_Bank_43_Block0_1').
fun('bank', obj_convert_t_address_to_t_address, [var(v0)], [var(v2)], 'obj_convert_t_address_to_t_address_Block0_1').
fun('bank', obj_convert_t_uint160_to_t_address, [var(v0)], [var(v2)], 'obj_convert_t_uint160_to_t_address_Block0_1').
fun('bank', obj_convert_t_uint160_to_t_uint160, [var(v0)], [var(v3), var(v4), var(v2)], 'obj_convert_t_uint160_to_t_uint160_Block0_1').
fun('bank', obj_identity, [var(v0)], [], 'obj_identity_ret').
fun('bank', obj_prepare_store_t_address, [var(v0)], [], 'obj_prepare_store_t_address_ret').
fun('bank', obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('bank', obj_shift_left_0, [var(v0)], [var(v2)], 'obj_shift_left_0_Block0_1').
fun('bank', obj_update_byte_slice_20_shift_0, [var(v0), var(v1)], [var(v4), var(v7), var(v8), var(v5), var(v6)], 'obj_update_byte_slice_20_shift_0_Block0_1').
fun('bank', obj_update_storage_value_offset_0_t_address_to_t_address, [var(v0), var(v1)], [var(v3), var(v4), var(v5), var(v2)], 'obj_update_storage_value_offset_0_t_address_to_t_address_Block0_1').
fun('bank', subO_abi_decode_t_uint256, [var(v0), var(v1)], [var(v3)], 'subO_abi_decode_t_uint256_Block0_1').
fun('bank', subO_abi_decode_tuple_, [var(v0), var(v1)], [var(v3), var(v4)], 'subO_abi_decode_tuple__Block0_1').
fun('bank', subO_abi_decode_tuple_t_uint256, [var(v0), var(v1)], [var(v11), var(v12), var(v5), var(v4)], 'subO_abi_decode_tuple_t_uint256_Block0_1').
fun('bank', subO_abi_encode_tuple__to__fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple__to__fromStack_Block0_1').
fun('bank', subO_allocate_unbounded, [], [var(v2)], 'subO_allocate_unbounded_Block0_1').
fun('bank', subO_assert_helper, [var(v0)], [var(v1)], 'subO_assert_helper_Block0_1').
fun('bank', subO_checked_sub_t_uint256, [var(v0), var(v1)], [var(v6), var(v3), var(v5), var(v4)], 'subO_checked_sub_t_uint256_Block0_1').
fun('bank', subO_cleanup_from_storage_t_address, [var(v0)], [var(v3)], 'subO_cleanup_from_storage_t_address_Block0_1').
fun('bank', subO_cleanup_from_storage_t_uint256, [var(v0)], [], 'subO_cleanup_from_storage_t_uint256_ret').
fun('bank', subO_cleanup_t_uint256, [var(v0)], [], 'subO_cleanup_t_uint256_ret').
fun('bank', subO_external_fun_deposit_19, [], [var(v3), var(v4), var(v0), var(v2)], 'subO_external_fun_deposit_19_Block0_1').
fun('bank', subO_external_fun_withdraw_42, [], [var(v4), var(v0), var(v5), var(v6), var(v3), var(v1)], 'subO_external_fun_withdraw_42_Block0_1').
fun('bank', subO_extract_from_storage_value_offset_0_t_address, [var(v0)], [var(v3), var(v2)], 'subO_extract_from_storage_value_offset_0_t_address_Block0_1').
fun('bank', subO_extract_from_storage_value_offset_0_t_uint256, [var(v0)], [var(v3), var(v2)], 'subO_extract_from_storage_value_offset_0_t_uint256_Block0_1').
fun('bank', subO_fun_deposit_19, [], [var(v4), var(v5), var(v2), var(v6), var(v3), var(v1)], 'subO_fun_deposit_19_Block0_1').
fun('bank', subO_fun_withdraw_42, [var(v0)], [var(v23), var(v5), var(v2), var(v12), var(v13), var(v25), var(v7), var(v22), var(v6), var(v16), var(v37), var(v40), var(v38), var(v26), var(v24), var(v39), var(v11), var(v4), var(v21)], 'subO_fun_withdraw_42_Block0_1').
fun('bank', subO_panic_error_0x01, [], [], 'subO_panic_error_0x01_Block0_1').
fun('bank', subO_panic_error_0x11, [], [], 'subO_panic_error_0x11_Block0_1').
fun('bank', subO_read_from_storage_split_offset_0_t_address, [var(v0)], [var(v3), var(v2)], 'subO_read_from_storage_split_offset_0_t_address_Block0_1').
fun('bank', subO_read_from_storage_split_offset_0_t_uint256, [var(v0)], [var(v3), var(v2)], 'subO_read_from_storage_split_offset_0_t_uint256_Block0_1').
fun('bank', subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [], 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1').
fun('bank', subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db, [], [], 'subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1').
fun('bank', subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun('bank', subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun('bank', subO_shift_right_0_unsigned, [var(v0)], [var(v2)], 'subO_shift_right_0_unsigned_Block0_1').
fun('bank', subO_shift_right_224_unsigned, [var(v0)], [var(v3)], 'subO_shift_right_224_unsigned_Block0_1').
fun('bank', subO_validator_revert_t_uint256, [var(v0)], [var(v3), var(v1), var(v2)], 'subO_validator_revert_t_uint256_Block0_1').
fun('bank', r_Bank_43_deployed, [], [var(v11), var(v4), var(v7), var(v8), var(v5), var(v9), var(v3)], 'Bank_43_deployed_Block0_1').
fun('bank', init_contract, [], [var(v4), var(v0), var(v5), var(v2), var(v6), var(v3)], 'init_contract_Block0_1').

at('bank', 'obj_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('bank', 'obj_allocate_unbounded_Block0_1', 'obj_allocate_unbounded_ret').
at('bank', 'obj_allocate_unbounded_ret', ret([var(v2)])).
at('bank', 'obj_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('bank', 'obj_cleanup_t_uint160_Block0_1', 'obj_cleanup_t_uint160_ret').
at('bank', 'obj_cleanup_t_uint160_ret', ret([var(v3)])).
at('bank', 'obj_constructor_Bank_43_Block0_1', asgn(var(v0), expr(caller))).
nextlab('bank', 'obj_constructor_Bank_43_Block0_1', 'obj_constructor_Bank_43_Block0_2').
at('bank', 'obj_constructor_Bank_43_Block0_2', fun_call(obj_update_storage_value_offset_0_t_address_to_t_address, [var(v0), off(0x01)], [])).
nextlab('bank', 'obj_constructor_Bank_43_Block0_2', 'obj_constructor_Bank_43_ret').
at('bank', 'obj_constructor_Bank_43_ret', ret([])).
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
at('bank', 'subO_abi_encode_tuple__to__fromStack_Block0_1', asgn(var(v2), expr(add([num(0x00), var(v0)])))).
nextlab('bank', 'subO_abi_encode_tuple__to__fromStack_Block0_1', 'subO_abi_encode_tuple__to__fromStack_ret').
at('bank', 'subO_abi_encode_tuple__to__fromStack_ret', ret([var(v2)])).
at('bank', 'subO_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('bank', 'subO_allocate_unbounded_Block0_1', 'subO_allocate_unbounded_ret').
at('bank', 'subO_allocate_unbounded_ret', ret([var(v2)])).
at('bank', 'subO_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('bank', 'subO_assert_helper_Block0_1', 'subO_assert_helper_Block0_2').
at('bank', 'subO_assert_helper_Block0_2', cj(var(v1), 'subO_assert_helper_ret', 'subO_assert_helper_Block1_1')).
at('bank', 'subO_assert_helper_ret', ret([])).
at('bank', 'subO_assert_helper_Block1_1', fun_call(subO_panic_error_0x01, [], [])).
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
at('bank', 'subO_cleanup_t_uint256_ret', ret([var(v0)])).
at('bank', 'subO_external_fun_deposit_19_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_1', 'subO_external_fun_deposit_19_Block0_2').
at('bank', 'subO_external_fun_deposit_19_Block0_2', fun_call(subO_abi_decode_tuple_, [var(v0), num(0x04)], [])).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_2', 'subO_external_fun_deposit_19_Block0_3').
at('bank', 'subO_external_fun_deposit_19_Block0_3', fun_call(subO_fun_deposit_19, [], [])).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_3', 'subO_external_fun_deposit_19_Block0_4').
at('bank', 'subO_external_fun_deposit_19_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v2)])).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_4', 'subO_external_fun_deposit_19_Block0_5').
at('bank', 'subO_external_fun_deposit_19_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v2)], [var(v3)])).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_5', 'subO_external_fun_deposit_19_Block0_6').
at('bank', 'subO_external_fun_deposit_19_Block0_6', asgn(var(v4), expr(sub([var(v2), var(v3)])))).
nextlab('bank', 'subO_external_fun_deposit_19_Block0_6', 'subO_external_fun_deposit_19_Block0_7').
at('bank', 'subO_external_fun_deposit_19_Block0_7', return([var(v4), var(v2)])).
at('bank', 'subO_external_fun_withdraw_42_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('bank', 'subO_external_fun_withdraw_42_Block0_1', 'subO_external_fun_withdraw_42_Block0_2').
at('bank', 'subO_external_fun_withdraw_42_Block0_2', cj(var(v0), 'subO_external_fun_withdraw_42_Block2_1', 'subO_external_fun_withdraw_42_Block1_1')).
at('bank', 'subO_external_fun_withdraw_42_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_1', 'subO_external_fun_withdraw_42_Block2_2').
at('bank', 'subO_external_fun_withdraw_42_Block2_2', fun_call(subO_abi_decode_tuple_t_uint256, [var(v1), num(0x04)], [var(v3)])).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_2', 'subO_external_fun_withdraw_42_Block2_3').


at('bank', 'subO_external_fun_withdraw_42_Block2_3', fun_call(subO_fun_withdraw_42, [var(v3)], [])).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_3', 'subO_external_fun_withdraw_42_Block2_4').
at('bank', 'subO_external_fun_withdraw_42_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v4)])).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_4', 'subO_external_fun_withdraw_42_Block2_5').


at('bank', 'subO_external_fun_withdraw_42_Block2_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v4)], [var(v5)])).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_5', 'subO_external_fun_withdraw_42_Block2_6').
at('bank', 'subO_external_fun_withdraw_42_Block2_6', asgn(var(v6), expr(sub([var(v4), var(v5)])))).
nextlab('bank', 'subO_external_fun_withdraw_42_Block2_6', 'subO_external_fun_withdraw_42_Block2_7').
at('bank', 'subO_external_fun_withdraw_42_Block2_7', return([var(v6), var(v4)])).
at('bank', 'subO_external_fun_withdraw_42_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
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
at('bank', 'subO_fun_deposit_19_Block0_1', asgn(var(v1), expr(callvalue))).
nextlab('bank', 'subO_fun_deposit_19_Block0_1', 'subO_fun_deposit_19_Block0_2').
at('bank', 'subO_fun_deposit_19_Block0_2', asgn(var(v2), expr(gt([num(0x00), var(v1)])))).
nextlab('bank', 'subO_fun_deposit_19_Block0_2', 'subO_fun_deposit_19_Block0_3').
at('bank', 'subO_fun_deposit_19_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('bank', 'subO_fun_deposit_19_Block0_3', 'subO_fun_deposit_19_Block0_4').
at('bank', 'subO_fun_deposit_19_Block0_4', cj(var(v3), 'subO_fun_deposit_19_Block2_1', 'subO_fun_deposit_19_Block1_1')).
at('bank', 'subO_fun_deposit_19_Block2_1', asgn(var(v4), expr(sload([off(0x00)])))).
nextlab('bank', 'subO_fun_deposit_19_Block2_1', 'subO_fun_deposit_19_Block2_2').
at('bank', 'subO_fun_deposit_19_Block2_2', asgn(var(v5), expr(callvalue))).
nextlab('bank', 'subO_fun_deposit_19_Block2_2', 'subO_fun_deposit_19_Block2_3').
at('bank', 'subO_fun_deposit_19_Block2_3', asgn(var(v6), expr(add([var(v5), var(v4)])))).
nextlab('bank', 'subO_fun_deposit_19_Block2_3', 'subO_fun_deposit_19_Block2_4').
at('bank', 'subO_fun_deposit_19_Block2_4', sstore([var(v6), off(0x00)])).
nextlab('bank', 'subO_fun_deposit_19_Block2_4', 'subO_fun_deposit_19_ret').
at('bank', 'subO_fun_deposit_19_ret', ret([])).
at('bank', 'subO_fun_deposit_19_Block1_1', revert([num(0x00), mem(0x00)])).


at('bank', 'subO_fun_withdraw_42_Block0_1', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v2)])).
nextlab('bank', 'subO_fun_withdraw_42_Block0_1', 'subO_fun_withdraw_42_Block0_2').
at('bank', 'subO_fun_withdraw_42_Block0_2', fun_call(subO_read_from_storage_split_offset_0_t_address, [off(0x01)], [var(v4)])).
nextlab('bank', 'subO_fun_withdraw_42_Block0_2', 'subO_fun_withdraw_42_Block0_3').
at('bank', 'subO_fun_withdraw_42_Block0_3', asgn(var(v5), expr(caller))).
nextlab('bank', 'subO_fun_withdraw_42_Block0_3', 'subO_fun_withdraw_42_Block0_4').
at('bank', 'subO_fun_withdraw_42_Block0_4', asgn(var(v6), expr(eq([var(v4), var(v5)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block0_4', 'subO_fun_withdraw_42_Block0_5').
at('bank', 'subO_fun_withdraw_42_Block0_5', asgn(var(v7), expr(iszero([var(v6)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block0_5', 'subO_fun_withdraw_42_Block0_6').
at('bank', 'subO_fun_withdraw_42_Block0_6', cj(var(v7), 'subO_fun_withdraw_42_Block2_1', 'subO_fun_withdraw_42_Block1_1')).
at('bank', 'subO_fun_withdraw_42_Block2_1', asgn(var(v11), expr(gt([num(0x00), var(v0)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block2_1', 'subO_fun_withdraw_42_Block2_2').
at('bank', 'subO_fun_withdraw_42_Block2_2', asgn(var(v12), expr(iszero([var(v11)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block2_2', 'subO_fun_withdraw_42_Block2_3').
at('bank', 'subO_fun_withdraw_42_Block2_3', cj(var(v12), 'subO_fun_withdraw_42_Block5_1', 'subO_fun_withdraw_42_Block4_1')).
at('bank', 'subO_fun_withdraw_42_Block1_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_fun_withdraw_42_Block5_1', asgn(var(v13), expr(sload([off(0x00)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block5_1', 'subO_fun_withdraw_42_Block5_2').
at('bank', 'subO_fun_withdraw_42_Block5_2', asgn(var(v16), expr(lt([var(v0), var(v13)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block5_2', 'subO_fun_withdraw_42_Block5_3').
at('bank', 'subO_fun_withdraw_42_Block5_3', cj(var(v16), 'subO_fun_withdraw_42_Block8_1', 'subO_fun_withdraw_42_Block7_1')).
at('bank', 'subO_fun_withdraw_42_Block4_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_fun_withdraw_42_Block8_1', asgn(var(v21), expr(sub([var(v0), var(v13)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block8_1', 'subO_fun_withdraw_42_Block8_2').
at('bank', 'subO_fun_withdraw_42_Block8_2', sstore([var(v21), off(0x00)])).
nextlab('bank', 'subO_fun_withdraw_42_Block8_2', 'subO_fun_withdraw_42_Block8_3').
at('bank', 'subO_fun_withdraw_42_Block8_3', asgn(var(v22), expr(caller))).
nextlab('bank', 'subO_fun_withdraw_42_Block8_3', 'subO_fun_withdraw_42_Block8_4').
at('bank', 'subO_fun_withdraw_42_Block8_4', asgn(var(v23), expr(gas))).
nextlab('bank', 'subO_fun_withdraw_42_Block8_4', 'subO_fun_withdraw_42_Block8_5').
at('bank', 'subO_fun_withdraw_42_Block8_5', call([num(0x00), num(0x00), num(0x00), num(0x00), var(v0), var(v22), var(v23)], var(v24))).
nextlab('bank', 'subO_fun_withdraw_42_Block8_5', 'subO_fun_withdraw_42_Block8_6').
at('bank', 'subO_fun_withdraw_42_Block8_6', asgn(var(v25), expr(iszero([var(v24)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block8_6', 'subO_fun_withdraw_42_Block8_7').
at('bank', 'subO_fun_withdraw_42_Block8_7', cj(var(v25), 'subO_fun_withdraw_42_Block11_1', 'subO_fun_withdraw_42_Block10_1')).
at('bank', 'subO_fun_withdraw_42_Block7_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_fun_withdraw_42_Block11_1', fun_call(subO_read_from_storage_split_offset_0_t_uint256, [off(0x00)], [var(v26)])).
nextlab('bank', 'subO_fun_withdraw_42_Block11_1', 'subO_fun_withdraw_42_Block11_2').
at('bank', 'subO_fun_withdraw_42_Block11_2', fun_call(subO_checked_sub_t_uint256, [var(v0), var(v2)], [var(v37)])).
nextlab('bank', 'subO_fun_withdraw_42_Block11_2', 'subO_fun_withdraw_42_Block11_3').
at('bank', 'subO_fun_withdraw_42_Block11_3', fun_call(subO_cleanup_t_uint256, [var(v37)], [var(v38)])).
nextlab('bank', 'subO_fun_withdraw_42_Block11_3', 'subO_fun_withdraw_42_Block11_4').
at('bank', 'subO_fun_withdraw_42_Block11_4', fun_call(subO_cleanup_t_uint256, [var(v26)], [var(v39)])).
nextlab('bank', 'subO_fun_withdraw_42_Block11_4', 'subO_fun_withdraw_42_Block11_5').
at('bank', 'subO_fun_withdraw_42_Block11_5', asgn(var(v40), expr(eq([var(v38), var(v39)])))).
nextlab('bank', 'subO_fun_withdraw_42_Block11_5', 'subO_fun_withdraw_42_Block11_6').
at('bank', 'subO_fun_withdraw_42_Block11_6', fun_call(subO_assert_helper, [var(v40)], [])).
nextlab('bank', 'subO_fun_withdraw_42_Block11_6', 'subO_fun_withdraw_42_ret').
at('bank', 'subO_fun_withdraw_42_ret', ret([])).
at('bank', 'subO_fun_withdraw_42_Block10_1', revert([num(0x00), mem(0x00)])).


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
at('bank', 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('bank', 'subO_shift_right_0_unsigned_Block0_1', asgn(var(v2), expr(shr([var(v0), num(0x00)])))).
nextlab('bank', 'subO_shift_right_0_unsigned_Block0_1', 'subO_shift_right_0_unsigned_ret').
at('bank', 'subO_shift_right_0_unsigned_ret', ret([var(v2)])).
at('bank', 'subO_shift_right_224_unsigned_Block0_1', asgn(var(v3), expr(shr([var(v0), num(0xe0)])))).
nextlab('bank', 'subO_shift_right_224_unsigned_Block0_1', 'subO_shift_right_224_unsigned_ret').
at('bank', 'subO_shift_right_224_unsigned_ret', ret([var(v3)])).
at('bank', 'subO_validator_revert_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint256, [var(v0)], [var(v1)])).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_1', 'subO_validator_revert_t_uint256_Block0_2').
at('bank', 'subO_validator_revert_t_uint256_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_2', 'subO_validator_revert_t_uint256_Block0_3').
at('bank', 'subO_validator_revert_t_uint256_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('bank', 'subO_validator_revert_t_uint256_Block0_3', 'subO_validator_revert_t_uint256_Block0_4').
at('bank', 'subO_validator_revert_t_uint256_Block0_4', cj(var(v3), 'subO_validator_revert_t_uint256_ret', 'subO_validator_revert_t_uint256_Block1_1')).
at('bank', 'subO_validator_revert_t_uint256_ret', ret([])).
at('bank', 'subO_validator_revert_t_uint256_Block1_1', revert([num(0x00), mem(0x00)])).
at('bank', 'start_contract', fun_call(init_contract, [], [])).
nextlab('bank', 'start_contract', 'runtime_contract').
at('bank', 'runtime_contract', fun_call(r_Bank_43_deployed, [], [])).
at('bank', 'init_contract_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('bank', 'init_contract_Block0_1', 'init_contract_Block0_2').
at('bank', 'init_contract_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('bank', 'init_contract_Block0_2', 'init_contract_Block0_3').
at('bank', 'init_contract_Block0_3', asgn(var(v2), expr(callvalue))).
nextlab('bank', 'init_contract_Block0_3', 'init_contract_Block0_4').
at('bank', 'init_contract_Block0_4', cj(var(v2), 'init_contract_Block2_1', 'init_contract_Block1_1')).
at('bank', 'init_contract_Block2_1', fun_call(obj_constructor_Bank_43, [], [])).
nextlab('bank', 'init_contract_Block2_1', 'init_contract_ret').
at('bank', 'init_contract_ret', ret([])).
at('bank', 'init_contract_Block1_1', fun_call(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('bank', 'Bank_43_deployed_Block0_1', mstore([num(0x80), mem(0x40)])).
nextlab('bank', 'Bank_43_deployed_Block0_1', 'Bank_43_deployed_Block0_2').
at('bank', 'Bank_43_deployed_Block0_2', asgn(var(v3), expr(calldatasize))).
nextlab('bank', 'Bank_43_deployed_Block0_2', 'Bank_43_deployed_Block0_3').
at('bank', 'Bank_43_deployed_Block0_3', asgn(var(v4), expr(lt([num(0x04), var(v3)])))).
nextlab('bank', 'Bank_43_deployed_Block0_3', 'Bank_43_deployed_Block0_4').
at('bank', 'Bank_43_deployed_Block0_4', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('bank', 'Bank_43_deployed_Block0_4', 'Bank_43_deployed_Block0_5').
at('bank', 'Bank_43_deployed_Block0_5', cj(var(v5), 'Bank_43_deployed_Block2_1', 'Bank_43_deployed_Block1_1')).
at('bank', 'Bank_43_deployed_Block2_1', fun_call(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [])).
at('bank', 'Bank_43_deployed_Block1_1', asgn(var(v7), expr(calldataload([num(0x00)])))).
nextlab('bank', 'Bank_43_deployed_Block1_1', 'Bank_43_deployed_Block1_2').
at('bank', 'Bank_43_deployed_Block1_2', fun_call(subO_shift_right_224_unsigned, [var(v7)], [var(v8)])).
nextlab('bank', 'Bank_43_deployed_Block1_2', 'Bank_43_deployed_Block1_3').
at('bank', 'Bank_43_deployed_Block1_3', asgn(var(v9), expr(eq([num(0x2e1a7d4d), var(v8)])))).
nextlab('bank', 'Bank_43_deployed_Block1_3', 'Bank_43_deployed_Block1_4').
at('bank', 'Bank_43_deployed_Block1_4', cj(var(v9), 'Bank_43_deployed_Block5_1', 'Bank_43_deployed_Block4_1')).
at('bank', 'Bank_43_deployed_Block5_1', asgn(var(v11), expr(eq([num(0xd0e30db0), var(v8)])))).
nextlab('bank', 'Bank_43_deployed_Block5_1', 'Bank_43_deployed_Block5_2').
at('bank', 'Bank_43_deployed_Block5_2', cj(var(v11), 'Bank_43_deployed_Block8_1', 'Bank_43_deployed_Block7_1')).
at('bank', 'Bank_43_deployed_Block4_1', fun_call(subO_external_fun_withdraw_42, [], [])).
at('bank', 'Bank_43_deployed_Block8_1', goto('Bank_43_deployed_Block3_1')).
at('bank', 'Bank_43_deployed_Block7_1', fun_call(subO_external_fun_deposit_19, [], [])).
at('bank', 'Bank_43_deployed_Block3_1', goto('Bank_43_deployed_Block2_1')).
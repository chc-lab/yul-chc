:- dynamic at/2.
:- discontiguous at/2.
:- discontiguous nextlab/2.
% ownable.sol:ContractSimple contract
signatures([('external_fun_owner_90', '0x8da5cb5b00000000000000000000000000000000000000000000000000000000'), ('external_fun_transferOwnership_82', '0xf2fde38b00000000000000000000000000000000000000000000000000000000')]).

globals([0x00]).
memory([0x00, 0x04, 0x1c, 0x40, 0x80, 0x128, 0xa0, 0xc0, 0xe0]).

fun(obj_allocate_unbounded, [], [var(v2)], 'obj_allocate_unbounded_Block0_1').
fun(obj_assert_helper, [var(v0)], [var(v1)], 'obj_assert_helper_Block0_1').
fun(obj_cleanup_t_uint160, [var(v0)], [var(v3)], 'obj_cleanup_t_uint160_Block0_1').
fun(obj_cleanup_t_uint256, [var(v0)], [], 'obj_cleanup_t_uint256_ret').
fun(obj_constructor_ContractSimple_111, [], [var(v0)], 'obj_constructor_ContractSimple_111_Block0_1').
fun(obj_constructor_Ownable_99, [], [], 'obj_constructor_Ownable_99_ret').
fun(obj_convert_t_uint160_to_t_uint256, [var(v0)], [var(v3), var(v4), var(v2)], 'obj_convert_t_uint160_to_t_uint256_Block0_1').
fun(obj_fun__initializeOwner_51, [var(v0)], [], 'obj_fun__initializeOwner_51_Block0_1').
fun(obj_fun__valid_address_40, [], [var(v2), var(v5), var(v7), var(v1), var(v6), var(v4)], 'obj_fun__valid_address_40_Block0_1').
fun(obj_identity, [var(v0)], [], 'obj_identity_ret').
fun(obj_panic_error_0x01, [], [], 'obj_panic_error_0x01_Block0_1').
fun(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun(obj_zero_value_for_split_t_uint256, [], [], 'obj_zero_value_for_split_t_uint256_ret').
fun(subO_abi_decode_t_address, [var(v0), var(v1)], [var(v3)], 'subO_abi_decode_t_address_Block0_1').
fun(subO_abi_decode_tuple_, [var(v0), var(v1)], [var(v3), var(v4)], 'subO_abi_decode_tuple__Block0_1').
fun(subO_abi_decode_tuple_t_address, [var(v0), var(v1)], [var(v4), var(v12), var(v5), var(v11)], 'subO_abi_decode_tuple_t_address_Block0_1').
fun(subO_abi_encode_t_address_to_t_address_fromStack, [var(v0), var(v1)], [var(v2)], 'subO_abi_encode_t_address_to_t_address_fromStack_Block0_1').
fun(subO_abi_encode_tuple__to__fromStack, [var(v0)], [var(v2)], 'subO_abi_encode_tuple__to__fromStack_Block0_1').
fun(subO_abi_encode_tuple_t_address__to_t_address__fromStack, [var(v0), var(v1)], [var(v4), var(v5)], 'subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_1').
fun(subO_allocate_unbounded, [], [var(v2)], 'subO_allocate_unbounded_Block0_1').
fun(subO_assert_helper, [var(v0)], [var(v1)], 'subO_assert_helper_Block0_1').
fun(subO_cleanup_t_address, [var(v0)], [var(v2)], 'subO_cleanup_t_address_Block0_1').
fun(subO_cleanup_t_uint160, [var(v0)], [var(v3)], 'subO_cleanup_t_uint160_Block0_1').
fun(subO_cleanup_t_uint256, [var(v0)], [], 'subO_cleanup_t_uint256_ret').
fun(subO_convert_t_uint160_to_t_uint256, [var(v0)], [var(v3), var(v4), var(v2)], 'subO_convert_t_uint160_to_t_uint256_Block0_1').
fun(subO_external_fun_owner_90, [], [var(v5), var(v1), var(v6), var(v4), var(v0), var(v3)], 'subO_external_fun_owner_90_Block0_1').
fun(subO_external_fun_transferOwnership_82, [], [var(v2), var(v5), var(v4), var(v0), var(v3)], 'subO_external_fun_transferOwnership_82_Block0_1').
fun(subO_fun__checkOwner_68, [], [var(v3), var(v4), var(v2), var(v1)], 'subO_fun__checkOwner_68_Block0_1').
fun(subO_fun__setOwner_62, [var(v0)], [var(v2)], 'subO_fun__setOwner_62_Block0_1').
fun(subO_fun__valid_address_40, [], [var(v2), var(v5), var(v7), var(v1), var(v6), var(v4)], 'subO_fun__valid_address_40_Block0_1').
fun(subO_fun_owner_90, [], [var(v2), var(v1)], 'subO_fun_owner_90_Block0_1').
fun(subO_fun_transferOwnership_82, [var(v0)], [], 'subO_fun_transferOwnership_82_Block0_1').
fun(subO_fun_transferOwnership_82_inner, [var(v0)], [var(v1)], 'subO_fun_transferOwnership_82_inner_Block0_1').
fun(subO_identity, [var(v0)], [], 'subO_identity_ret').
fun(subO_modifier_onlyOwner_74, [var(v0)], [], 'subO_modifier_onlyOwner_74_Block0_1').
fun(subO_panic_error_0x01, [], [], 'subO_panic_error_0x01_Block0_1').
fun(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [], 'subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1').
fun(subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db, [], [], 'subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1').
fun(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [], 'subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1').
fun(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [], 'subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1').
fun(subO_shift_right_224_unsigned, [var(v0)], [var(v3)], 'subO_shift_right_224_unsigned_Block0_1').
fun(subO_validator_revert_t_address, [var(v0)], [var(v3), var(v2), var(v1)], 'subO_validator_revert_t_address_Block0_1').
fun(subO_zero_value_for_split_t_address, [], [], 'subO_zero_value_for_split_t_address_ret').
fun(subO_zero_value_for_split_t_uint256, [], [], 'subO_zero_value_for_split_t_uint256_ret').
fun(r_ContractSimple_111_deployed, [], [var(v5), var(v7), var(v9), var(v4), var(v0), var(v8), var(v3), var(v11)], 'ContractSimple_111_deployed_Block0_1').
fun(init_contract, [], [var(v2), var(v5), var(v6), var(v4), var(v0), var(v3)], 'init_contract_Block0_1').

% Combined at and nextlab relations
at('obj_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('obj_allocate_unbounded_Block0_1', 'obj_allocate_unbounded_ret').
at('obj_allocate_unbounded_ret', ret([var(v2)])).
at('obj_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('obj_assert_helper_Block0_1', 'obj_assert_helper_Block0_2').
at('obj_assert_helper_Block0_2', cj(var(v1), 'obj_assert_helper_ret', 'obj_assert_helper_Block1_1')).
at('obj_assert_helper_ret', ret([])).
at('obj_assert_helper_Block1_1', fun_call(obj_panic_error_0x01, [], [])).
at('obj_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('obj_cleanup_t_uint160_Block0_1', 'obj_cleanup_t_uint160_ret').
at('obj_cleanup_t_uint160_ret', ret([var(v3)])).
at('obj_cleanup_t_uint256_ret', ret([var(v0)])).
at('obj_constructor_ContractSimple_111_Block0_1', fun_call(obj_constructor_Ownable_99, [], [])).
nextlab('obj_constructor_ContractSimple_111_Block0_1', 'obj_constructor_ContractSimple_111_Block0_2').
at('obj_constructor_ContractSimple_111_Block0_2', asgn(var(v0), expr(caller))).
nextlab('obj_constructor_ContractSimple_111_Block0_2', 'obj_constructor_ContractSimple_111_Block0_3').
at('obj_constructor_ContractSimple_111_Block0_3', fun_call(obj_fun__initializeOwner_51, [var(v0)], [])).
nextlab('obj_constructor_ContractSimple_111_Block0_3', 'obj_constructor_ContractSimple_111_ret').
at('obj_constructor_ContractSimple_111_ret', ret([])).
at('obj_constructor_Ownable_99_ret', ret([])).
at('obj_convert_t_uint160_to_t_uint256_Block0_1', fun_call(obj_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('obj_convert_t_uint160_to_t_uint256_Block0_1', 'obj_convert_t_uint160_to_t_uint256_Block0_2').
at('obj_convert_t_uint160_to_t_uint256_Block0_2', fun_call(obj_identity, [var(v2)], [var(v3)])).
nextlab('obj_convert_t_uint160_to_t_uint256_Block0_2', 'obj_convert_t_uint160_to_t_uint256_Block0_3').
at('obj_convert_t_uint160_to_t_uint256_Block0_3', fun_call(obj_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('obj_convert_t_uint160_to_t_uint256_Block0_3', 'obj_convert_t_uint160_to_t_uint256_ret').
at('obj_convert_t_uint160_to_t_uint256_ret', ret([var(v4)])).
at('obj_fun__initializeOwner_51_Block0_1', sstore([var(v0), off(0x00)])).
nextlab('obj_fun__initializeOwner_51_Block0_1', 'obj_fun__initializeOwner_51_Block0_2').
at('obj_fun__initializeOwner_51_Block0_2', log3([var(v0), num(0x00), num(0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0), num(0x00), num(0x00)])).
nextlab('obj_fun__initializeOwner_51_Block0_2', 'obj_fun__initializeOwner_51_Block0_3').
at('obj_fun__initializeOwner_51_Block0_3', fun_call(obj_fun__valid_address_40, [], [])).
nextlab('obj_fun__initializeOwner_51_Block0_3', 'obj_fun__initializeOwner_51_ret').
at('obj_fun__initializeOwner_51_ret', ret([])).
at('obj_fun__valid_address_40_Block0_1', fun_call(obj_zero_value_for_split_t_uint256, [], [var(v1)])).
nextlab('obj_fun__valid_address_40_Block0_1', 'obj_fun__valid_address_40_Block0_2').
at('obj_fun__valid_address_40_Block0_2', asgn(var(v2), expr(sload([off(0x00)])))).
nextlab('obj_fun__valid_address_40_Block0_2', 'obj_fun__valid_address_40_Block0_3').
at('obj_fun__valid_address_40_Block0_3', fun_call(obj_convert_t_uint160_to_t_uint256, [num(0xffffffffffffffffffffffffffffffffffffffff)], [var(v4)])).
nextlab('obj_fun__valid_address_40_Block0_3', 'obj_fun__valid_address_40_Block0_4').
at('obj_fun__valid_address_40_Block0_4', fun_call(obj_cleanup_t_uint256, [var(v2)], [var(v5)])).
nextlab('obj_fun__valid_address_40_Block0_4', 'obj_fun__valid_address_40_Block0_5').
at('obj_fun__valid_address_40_Block0_5', asgn(var(v6), expr(gt([var(v4), var(v5)])))).
nextlab('obj_fun__valid_address_40_Block0_5', 'obj_fun__valid_address_40_Block0_6').
at('obj_fun__valid_address_40_Block0_6', asgn(var(v7), expr(iszero([var(v6)])))).
nextlab('obj_fun__valid_address_40_Block0_6', 'obj_fun__valid_address_40_Block0_7').
at('obj_fun__valid_address_40_Block0_7', fun_call(obj_assert_helper, [var(v7)], [])).
nextlab('obj_fun__valid_address_40_Block0_7', 'obj_fun__valid_address_40_ret').
at('obj_fun__valid_address_40_ret', ret([])).
at('obj_identity_ret', ret([var(v0)])).
at('obj_panic_error_0x01_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('obj_panic_error_0x01_Block0_1', 'obj_panic_error_0x01_Block0_2').
at('obj_panic_error_0x01_Block0_2', mstore([num(0x01), mem(0x04)])).
nextlab('obj_panic_error_0x01_Block0_2', 'obj_panic_error_0x01_Block0_3').
at('obj_panic_error_0x01_Block0_3', revert([num(0x24), mem(0x00)])).
at('obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('obj_zero_value_for_split_t_uint256_ret', ret([num(0x00)])).
at('subO_abi_decode_t_address_Block0_1', asgn(var(v3), expr(calldataload([var(v0)])))).
nextlab('subO_abi_decode_t_address_Block0_1', 'subO_abi_decode_t_address_Block0_2').
at('subO_abi_decode_t_address_Block0_2', fun_call(subO_validator_revert_t_address, [var(v3)], [])).
nextlab('subO_abi_decode_t_address_Block0_2', 'subO_abi_decode_t_address_ret').
at('subO_abi_decode_t_address_ret', ret([var(v3)])).
at('subO_abi_decode_tuple__Block0_1', asgn(var(v3), expr(sub([var(v0), var(v1)])))).
nextlab('subO_abi_decode_tuple__Block0_1', 'subO_abi_decode_tuple__Block0_2').
at('subO_abi_decode_tuple__Block0_2', asgn(var(v4), expr(slt([num(0x00), var(v3)])))).
nextlab('subO_abi_decode_tuple__Block0_2', 'subO_abi_decode_tuple__Block0_3').
at('subO_abi_decode_tuple__Block0_3', cj(var(v4), 'subO_abi_decode_tuple__ret', 'subO_abi_decode_tuple__Block1_1')).
at('subO_abi_decode_tuple__ret', ret([])).
at('subO_abi_decode_tuple__Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('subO_abi_decode_tuple_t_address_Block0_1', asgn(var(v4), expr(sub([var(v0), var(v1)])))).
nextlab('subO_abi_decode_tuple_t_address_Block0_1', 'subO_abi_decode_tuple_t_address_Block0_2').
at('subO_abi_decode_tuple_t_address_Block0_2', asgn(var(v5), expr(slt([num(0x20), var(v4)])))).
nextlab('subO_abi_decode_tuple_t_address_Block0_2', 'subO_abi_decode_tuple_t_address_Block0_3').
at('subO_abi_decode_tuple_t_address_Block0_3', cj(var(v5), 'subO_abi_decode_tuple_t_address_Block2_1', 'subO_abi_decode_tuple_t_address_Block1_1')).
at('subO_abi_decode_tuple_t_address_Block2_1', asgn(var(v11), expr(add([num(0x00), var(v0)])))).
nextlab('subO_abi_decode_tuple_t_address_Block2_1', 'subO_abi_decode_tuple_t_address_Block2_2').
at('subO_abi_decode_tuple_t_address_Block2_2', fun_call(subO_abi_decode_t_address, [var(v1), var(v11)], [var(v12)])).
nextlab('subO_abi_decode_tuple_t_address_Block2_2', 'subO_abi_decode_tuple_t_address_ret').
at('subO_abi_decode_tuple_t_address_ret', ret([var(v12)])).
at('subO_abi_decode_tuple_t_address_Block1_1', fun_call(subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b, [], [])).
at('subO_abi_encode_t_address_to_t_address_fromStack_Block0_1', fun_call(subO_cleanup_t_address, [var(v0)], [var(v2)])).
nextlab('subO_abi_encode_t_address_to_t_address_fromStack_Block0_1', 'subO_abi_encode_t_address_to_t_address_fromStack_Block0_2').
at('subO_abi_encode_t_address_to_t_address_fromStack_Block0_2', mstore([var(v2), var(v1)])).
nextlab('subO_abi_encode_t_address_to_t_address_fromStack_Block0_2', 'subO_abi_encode_t_address_to_t_address_fromStack_ret').
at('subO_abi_encode_t_address_to_t_address_fromStack_ret', ret([])).
at('subO_abi_encode_tuple__to__fromStack_Block0_1', asgn(var(v2), expr(add([num(0x00), var(v0)])))).
nextlab('subO_abi_encode_tuple__to__fromStack_Block0_1', 'subO_abi_encode_tuple__to__fromStack_ret').
at('subO_abi_encode_tuple__to__fromStack_ret', ret([var(v2)])).
at('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_1', asgn(var(v4), expr(add([num(0x20), var(v0)])))).
nextlab('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_1', 'subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_2').
at('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_2', asgn(var(v5), expr(add([num(0x00), var(v0)])))).
nextlab('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_2', 'subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_3').
at('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_3', fun_call(subO_abi_encode_t_address_to_t_address_fromStack, [var(v5), var(v1)], [])).
nextlab('subO_abi_encode_tuple_t_address__to_t_address__fromStack_Block0_3', 'subO_abi_encode_tuple_t_address__to_t_address__fromStack_ret').
at('subO_abi_encode_tuple_t_address__to_t_address__fromStack_ret', ret([var(v4)])).
at('subO_allocate_unbounded_Block0_1', asgn(var(v2), expr(mload([mem(0x40)])))).
nextlab('subO_allocate_unbounded_Block0_1', 'subO_allocate_unbounded_ret').
at('subO_allocate_unbounded_ret', ret([var(v2)])).
at('subO_assert_helper_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('subO_assert_helper_Block0_1', 'subO_assert_helper_Block0_2').
at('subO_assert_helper_Block0_2', cj(var(v1), 'subO_assert_helper_ret', 'subO_assert_helper_Block1_1')).
at('subO_assert_helper_ret', ret([])).
at('subO_assert_helper_Block1_1', fun_call(subO_panic_error_0x01, [], [])).
at('subO_cleanup_t_address_Block0_1', fun_call(subO_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('subO_cleanup_t_address_Block0_1', 'subO_cleanup_t_address_ret').
at('subO_cleanup_t_address_ret', ret([var(v2)])).
at('subO_cleanup_t_uint160_Block0_1', asgn(var(v3), expr(and([num(0xffffffffffffffffffffffffffffffffffffffff), var(v0)])))).
nextlab('subO_cleanup_t_uint160_Block0_1', 'subO_cleanup_t_uint160_ret').
at('subO_cleanup_t_uint160_ret', ret([var(v3)])).
at('subO_cleanup_t_uint256_ret', ret([var(v0)])).
at('subO_convert_t_uint160_to_t_uint256_Block0_1', fun_call(subO_cleanup_t_uint160, [var(v0)], [var(v2)])).
nextlab('subO_convert_t_uint160_to_t_uint256_Block0_1', 'subO_convert_t_uint160_to_t_uint256_Block0_2').
at('subO_convert_t_uint160_to_t_uint256_Block0_2', fun_call(subO_identity, [var(v2)], [var(v3)])).
nextlab('subO_convert_t_uint160_to_t_uint256_Block0_2', 'subO_convert_t_uint160_to_t_uint256_Block0_3').
at('subO_convert_t_uint160_to_t_uint256_Block0_3', fun_call(subO_cleanup_t_uint256, [var(v3)], [var(v4)])).
nextlab('subO_convert_t_uint160_to_t_uint256_Block0_3', 'subO_convert_t_uint160_to_t_uint256_ret').
at('subO_convert_t_uint160_to_t_uint256_ret', ret([var(v4)])).
at('subO_external_fun_owner_90_Block0_1', asgn(var(v0), expr(callvalue))).
nextlab('subO_external_fun_owner_90_Block0_1', 'subO_external_fun_owner_90_Block0_2').
at('subO_external_fun_owner_90_Block0_2', cj(var(v0), 'subO_external_fun_owner_90_Block2_1', 'subO_external_fun_owner_90_Block1_1')).
at('subO_external_fun_owner_90_Block2_1', asgn(var(v1), expr(calldatasize))).
nextlab('subO_external_fun_owner_90_Block2_1', 'subO_external_fun_owner_90_Block2_2').
at('subO_external_fun_owner_90_Block2_2', fun_call(subO_abi_decode_tuple_, [var(v1), num(0x04)], [])).
nextlab('subO_external_fun_owner_90_Block2_2', 'subO_external_fun_owner_90_Block2_3').
at('subO_external_fun_owner_90_Block2_3', fun_call(subO_fun_owner_90, [], [var(v3)])).
nextlab('subO_external_fun_owner_90_Block2_3', 'subO_external_fun_owner_90_Block2_4').
at('subO_external_fun_owner_90_Block2_4', fun_call(subO_allocate_unbounded, [], [var(v4)])).
nextlab('subO_external_fun_owner_90_Block2_4', 'subO_external_fun_owner_90_Block2_5').
at('subO_external_fun_owner_90_Block2_5', fun_call(subO_abi_encode_tuple_t_address__to_t_address__fromStack, [var(v3), var(v4)], [var(v5)])).
nextlab('subO_external_fun_owner_90_Block2_5', 'subO_external_fun_owner_90_Block2_6').
at('subO_external_fun_owner_90_Block2_6', asgn(var(v6), expr(sub([var(v4), var(v5)])))).
nextlab('subO_external_fun_owner_90_Block2_6', 'subO_external_fun_owner_90_Block2_7').
at('subO_external_fun_owner_90_Block2_7', return([var(v6), var(v4)])).
at('subO_external_fun_owner_90_Block1_1', fun_call(subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('subO_external_fun_transferOwnership_82_Block0_1', asgn(var(v0), expr(calldatasize))).
nextlab('subO_external_fun_transferOwnership_82_Block0_1', 'subO_external_fun_transferOwnership_82_Block0_2').
at('subO_external_fun_transferOwnership_82_Block0_2', fun_call(subO_abi_decode_tuple_t_address, [var(v0), num(0x04)], [var(v2)])).
nextlab('subO_external_fun_transferOwnership_82_Block0_2', 'subO_external_fun_transferOwnership_82_Block0_3').
at('subO_external_fun_transferOwnership_82_Block0_3', fun_call(subO_fun_transferOwnership_82, [var(v2)], [])).
nextlab('subO_external_fun_transferOwnership_82_Block0_3', 'subO_external_fun_transferOwnership_82_Block0_4').
at('subO_external_fun_transferOwnership_82_Block0_4', fun_call(subO_allocate_unbounded, [], [var(v3)])).
nextlab('subO_external_fun_transferOwnership_82_Block0_4', 'subO_external_fun_transferOwnership_82_Block0_5').
at('subO_external_fun_transferOwnership_82_Block0_5', fun_call(subO_abi_encode_tuple__to__fromStack, [var(v3)], [var(v4)])).
nextlab('subO_external_fun_transferOwnership_82_Block0_5', 'subO_external_fun_transferOwnership_82_Block0_6').
at('subO_external_fun_transferOwnership_82_Block0_6', asgn(var(v5), expr(sub([var(v3), var(v4)])))).
nextlab('subO_external_fun_transferOwnership_82_Block0_6', 'subO_external_fun_transferOwnership_82_Block0_7').
at('subO_external_fun_transferOwnership_82_Block0_7', return([var(v5), var(v3)])).
at('subO_fun__checkOwner_68_Block0_1', asgn(var(v1), expr(sload([off(0x00)])))).
nextlab('subO_fun__checkOwner_68_Block0_1', 'subO_fun__checkOwner_68_Block0_2').
at('subO_fun__checkOwner_68_Block0_2', asgn(var(v2), expr(caller))).
nextlab('subO_fun__checkOwner_68_Block0_2', 'subO_fun__checkOwner_68_Block0_3').
at('subO_fun__checkOwner_68_Block0_3', asgn(var(v3), expr(eq([var(v1), var(v2)])))).
nextlab('subO_fun__checkOwner_68_Block0_3', 'subO_fun__checkOwner_68_Block0_4').
at('subO_fun__checkOwner_68_Block0_4', asgn(var(v4), expr(iszero([var(v3)])))).
nextlab('subO_fun__checkOwner_68_Block0_4', 'subO_fun__checkOwner_68_Block0_5').
at('subO_fun__checkOwner_68_Block0_5', cj(var(v4), 'subO_fun__checkOwner_68_ret', 'subO_fun__checkOwner_68_Block1_1')).
at('subO_fun__checkOwner_68_ret', ret([])).
at('subO_fun__checkOwner_68_Block1_1', mstore([num(0x82b42900), mem(0x00)])).
nextlab('subO_fun__checkOwner_68_Block1_1', 'subO_fun__checkOwner_68_Block1_2').
at('subO_fun__checkOwner_68_Block1_2', revert([num(0x04), mem(0x1c)])).
at('subO_fun__setOwner_62_Block0_1', asgn(var(v2), expr(sload([off(0x00)])))).
nextlab('subO_fun__setOwner_62_Block0_1', 'subO_fun__setOwner_62_Block0_2').
at('subO_fun__setOwner_62_Block0_2', log3([var(v0), var(v2), num(0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0), num(0x00), num(0x00)])).
nextlab('subO_fun__setOwner_62_Block0_2', 'subO_fun__setOwner_62_Block0_3').
at('subO_fun__setOwner_62_Block0_3', sstore([var(v0), off(0x00)])).
nextlab('subO_fun__setOwner_62_Block0_3', 'subO_fun__setOwner_62_Block0_4').
at('subO_fun__setOwner_62_Block0_4', fun_call(subO_fun__valid_address_40, [], [])).
nextlab('subO_fun__setOwner_62_Block0_4', 'subO_fun__setOwner_62_ret').
at('subO_fun__setOwner_62_ret', ret([])).
at('subO_fun__valid_address_40_Block0_1', fun_call(subO_zero_value_for_split_t_uint256, [], [var(v1)])).
nextlab('subO_fun__valid_address_40_Block0_1', 'subO_fun__valid_address_40_Block0_2').
at('subO_fun__valid_address_40_Block0_2', asgn(var(v2), expr(sload([off(0x00)])))).
nextlab('subO_fun__valid_address_40_Block0_2', 'subO_fun__valid_address_40_Block0_3').
at('subO_fun__valid_address_40_Block0_3', fun_call(subO_convert_t_uint160_to_t_uint256, [num(0xffffffffffffffffffffffffffffffffffffffff)], [var(v4)])).
nextlab('subO_fun__valid_address_40_Block0_3', 'subO_fun__valid_address_40_Block0_4').
at('subO_fun__valid_address_40_Block0_4', fun_call(subO_cleanup_t_uint256, [var(v2)], [var(v5)])).
nextlab('subO_fun__valid_address_40_Block0_4', 'subO_fun__valid_address_40_Block0_5').
at('subO_fun__valid_address_40_Block0_5', asgn(var(v6), expr(gt([var(v4), var(v5)])))).
nextlab('subO_fun__valid_address_40_Block0_5', 'subO_fun__valid_address_40_Block0_6').
at('subO_fun__valid_address_40_Block0_6', asgn(var(v7), expr(iszero([var(v6)])))).
nextlab('subO_fun__valid_address_40_Block0_6', 'subO_fun__valid_address_40_Block0_7').
at('subO_fun__valid_address_40_Block0_7', fun_call(subO_assert_helper, [var(v7)], [])).
nextlab('subO_fun__valid_address_40_Block0_7', 'subO_fun__valid_address_40_ret').
at('subO_fun__valid_address_40_ret', ret([])).
at('subO_fun_owner_90_Block0_1', fun_call(subO_zero_value_for_split_t_address, [], [var(v1)])).
nextlab('subO_fun_owner_90_Block0_1', 'subO_fun_owner_90_Block0_2').
at('subO_fun_owner_90_Block0_2', asgn(var(v2), expr(sload([off(0x00)])))).
nextlab('subO_fun_owner_90_Block0_2', 'subO_fun_owner_90_ret').
at('subO_fun_owner_90_ret', ret([var(v2)])).
at('subO_fun_transferOwnership_82_Block0_1', fun_call(subO_modifier_onlyOwner_74, [var(v0)], [])).
nextlab('subO_fun_transferOwnership_82_Block0_1', 'subO_fun_transferOwnership_82_ret').
at('subO_fun_transferOwnership_82_ret', ret([])).
at('subO_fun_transferOwnership_82_inner_Block0_1', asgn(var(v1), expr(iszero([var(v0)])))).
nextlab('subO_fun_transferOwnership_82_inner_Block0_1', 'subO_fun_transferOwnership_82_inner_Block0_2').
at('subO_fun_transferOwnership_82_inner_Block0_2', cj(var(v1), 'subO_fun_transferOwnership_82_inner_Block2_1', 'subO_fun_transferOwnership_82_inner_Block1_1')).
at('subO_fun_transferOwnership_82_inner_Block2_1', fun_call(subO_fun__setOwner_62, [var(v0)], [])).
nextlab('subO_fun_transferOwnership_82_inner_Block2_1', 'subO_fun_transferOwnership_82_inner_ret').
at('subO_fun_transferOwnership_82_inner_ret', ret([])).
at('subO_fun_transferOwnership_82_inner_Block1_1', mstore([num(0x7448fbae), mem(0x00)])).
nextlab('subO_fun_transferOwnership_82_inner_Block1_1', 'subO_fun_transferOwnership_82_inner_Block1_2').
at('subO_fun_transferOwnership_82_inner_Block1_2', revert([num(0x04), mem(0x1c)])).
at('subO_identity_ret', ret([var(v0)])).
at('subO_modifier_onlyOwner_74_Block0_1', fun_call(subO_fun__checkOwner_68, [], [])).
nextlab('subO_modifier_onlyOwner_74_Block0_1', 'subO_modifier_onlyOwner_74_Block0_2').
at('subO_modifier_onlyOwner_74_Block0_2', fun_call(subO_fun_transferOwnership_82_inner, [var(v0)], [])).
nextlab('subO_modifier_onlyOwner_74_Block0_2', 'subO_modifier_onlyOwner_74_ret').
at('subO_modifier_onlyOwner_74_ret', ret([])).
at('subO_panic_error_0x01_Block0_1', mstore([num(0x4e487b7100000000000000000000000000000000000000000000000000000000), mem(0x00)])).
nextlab('subO_panic_error_0x01_Block0_1', 'subO_panic_error_0x01_Block0_2').
at('subO_panic_error_0x01_Block0_2', mstore([num(0x01), mem(0x04)])).
nextlab('subO_panic_error_0x01_Block0_2', 'subO_panic_error_0x01_Block0_3').
at('subO_panic_error_0x01_Block0_3', revert([num(0x24), mem(0x00)])).
at('subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74_Block0_1', revert([num(0x00), mem(0x00)])).
at('subO_revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db_Block0_1', revert([num(0x00), mem(0x00)])).
at('subO_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb_Block0_1', revert([num(0x00), mem(0x00)])).
at('subO_revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b_Block0_1', revert([num(0x00), mem(0x00)])).
at('subO_shift_right_224_unsigned_Block0_1', asgn(var(v3), expr(shr([var(v0), num(0xe0)])))).
nextlab('subO_shift_right_224_unsigned_Block0_1', 'subO_shift_right_224_unsigned_ret').
at('subO_shift_right_224_unsigned_ret', ret([var(v3)])).
at('subO_validator_revert_t_address_Block0_1', fun_call(subO_cleanup_t_address, [var(v0)], [var(v1)])).
nextlab('subO_validator_revert_t_address_Block0_1', 'subO_validator_revert_t_address_Block0_2').
at('subO_validator_revert_t_address_Block0_2', asgn(var(v2), expr(eq([var(v1), var(v0)])))).
nextlab('subO_validator_revert_t_address_Block0_2', 'subO_validator_revert_t_address_Block0_3').
at('subO_validator_revert_t_address_Block0_3', asgn(var(v3), expr(iszero([var(v2)])))).
nextlab('subO_validator_revert_t_address_Block0_3', 'subO_validator_revert_t_address_Block0_4').
at('subO_validator_revert_t_address_Block0_4', cj(var(v3), 'subO_validator_revert_t_address_ret', 'subO_validator_revert_t_address_Block1_1')).
at('subO_validator_revert_t_address_ret', ret([])).
at('subO_validator_revert_t_address_Block1_1', revert([num(0x00), mem(0x00)])).
at('subO_zero_value_for_split_t_address_ret', ret([num(0x00)])).
at('subO_zero_value_for_split_t_uint256_ret', ret([num(0x00)])).
at('start_contract', fun_call(init_contract, [], [])).
nextlab('start_contract', 'runtime_contract').
at('runtime_contract', fun_call(r_ContractSimple_111_deployed, [], [])).
at('init_contract_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('init_contract_Block0_1', 'init_contract_Block0_2').
at('init_contract_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('init_contract_Block0_2', 'init_contract_Block0_3').
at('init_contract_Block0_3', asgn(var(v2), expr(callvalue))).
nextlab('init_contract_Block0_3', 'init_contract_Block0_4').
at('init_contract_Block0_4', cj(var(v2), 'init_contract_Block2_1', 'init_contract_Block1_1')).
at('init_contract_Block2_1', fun_call(obj_constructor_ContractSimple_111, [], [])).
nextlab('init_contract_Block2_1', 'init_contract_ret').
at('init_contract_ret', ret([])).
at('init_contract_Block1_1', fun_call(obj_revert_error_ca66f745a3ce8ff40e2ccaf1ad45db7774001b90d25810abd9040049be7bf4bb, [], [])).
at('ContractSimple_111_deployed_Block0_1', asgn(var(v0), expr(memoryguard))).
nextlab('ContractSimple_111_deployed_Block0_1', 'ContractSimple_111_deployed_Block0_2').
at('ContractSimple_111_deployed_Block0_2', mstore([var(v0), mem(0x40)])).
nextlab('ContractSimple_111_deployed_Block0_2', 'ContractSimple_111_deployed_Block0_3').
at('ContractSimple_111_deployed_Block0_3', asgn(var(v3), expr(calldatasize))).
nextlab('ContractSimple_111_deployed_Block0_3', 'ContractSimple_111_deployed_Block0_4').
at('ContractSimple_111_deployed_Block0_4', asgn(var(v4), expr(lt([num(0x04), var(v3)])))).
nextlab('ContractSimple_111_deployed_Block0_4', 'ContractSimple_111_deployed_Block0_5').
at('ContractSimple_111_deployed_Block0_5', asgn(var(v5), expr(iszero([var(v4)])))).
nextlab('ContractSimple_111_deployed_Block0_5', 'ContractSimple_111_deployed_Block0_6').
at('ContractSimple_111_deployed_Block0_6', cj(var(v5), 'ContractSimple_111_deployed_Block2_1', 'ContractSimple_111_deployed_Block1_1')).
at('ContractSimple_111_deployed_Block2_1', fun_call(subO_revert_error_42b3090547df1d2001c96683413b8cf91c1b902ef5e3cb8d9f6f304cf7446f74, [], [])).
at('ContractSimple_111_deployed_Block1_1', asgn(var(v7), expr(calldataload([num(0x00)])))).
nextlab('ContractSimple_111_deployed_Block1_1', 'ContractSimple_111_deployed_Block1_2').
at('ContractSimple_111_deployed_Block1_2', fun_call(subO_shift_right_224_unsigned, [var(v7)], [var(v8)])).
nextlab('ContractSimple_111_deployed_Block1_2', 'ContractSimple_111_deployed_Block1_3').
at('ContractSimple_111_deployed_Block1_3', asgn(var(v9), expr(eq([num(0x8da5cb5b), var(v8)])))).
nextlab('ContractSimple_111_deployed_Block1_3', 'ContractSimple_111_deployed_Block1_4').
at('ContractSimple_111_deployed_Block1_4', cj(var(v9), 'ContractSimple_111_deployed_Block5_1', 'ContractSimple_111_deployed_Block4_1')).
at('ContractSimple_111_deployed_Block5_1', asgn(var(v11), expr(eq([num(0xf2fde38b), var(v8)])))).
nextlab('ContractSimple_111_deployed_Block5_1', 'ContractSimple_111_deployed_Block5_2').
at('ContractSimple_111_deployed_Block5_2', cj(var(v11), 'ContractSimple_111_deployed_Block8_1', 'ContractSimple_111_deployed_Block7_1')).
at('ContractSimple_111_deployed_Block4_1', fun_call(subO_external_fun_owner_90, [], [])).
at('ContractSimple_111_deployed_Block8_1', goto('ContractSimple_111_deployed_Block3_1')).
at('ContractSimple_111_deployed_Block7_1', fun_call(subO_external_fun_transferOwnership_82, [], [])).
at('ContractSimple_111_deployed_Block3_1', goto('ContractSimple_111_deployed_Block2_1')).

:- include('Ownable.aux.pl').
module dce_rpc_rid;

export {
	redef record DCE_RPC::Info += {
		RID: count &optional &log;
	};

	global currennt_stub: string;
}

event dce_rpc_response(c: connection, fid: count, ctx_id: count, opnum: count,
    stub_len: count) &priority=0
	{
	if ( c?$dce_rpc )
		{
		if ( c$dce_rpc?$operation )
			{
			if ( ends_with(currennt_stub, "\x00\x02\x00\x00") )
				{
				c$dce_rpc$RID = 512;
				}
			}
		}
	}

event dce_rpc_request_stub(c: connection, fid: count, ctx_id: count,
    opnum: count, stub: string)
	{
	currennt_stub = stub;
	}

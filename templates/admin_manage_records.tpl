{assign var=records value=Controller::inConfig(record_types)}

<div class="row spacer_10">
	<div class="col-md-9">
		<p><strong>{$LANG.admin_manage_title_zone}:</strong>
			<br /><a href="clientsdomains.php?userid={$domain->userid}&id={$domain->id}">{$domain->domain}</a> {if $dnssec.nsec}<span class="label inactive"><span class="glyphicons glyphicons-unlock" aria-hidden="true"></span> {$dnssec.nsec}</span>{/if}</p>
	</div>
	<div class="col-md-3">
		<div class="text-right">
			<!-- Split button -->
			<div class="btn-group">
				<span data-toggle="modal" data-target="#dialog_addRecord">
                    <button type="button" class="btn btn-success btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$LANG.admin_manage_records_addrecord}" {if Controller::config(maintenance)}DISABLED{/if}><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
				</span>
			</div>
			<!-- Single button -->
			<div class="btn-group">
				<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false" {if Controller::config(maintenance)}DISABLED{/if}><span class="caret"></span></button>
				<ul class="dropdown-menu dropdown-menu-right" role="menu">
					<li><a href="#" data-toggle="modal" data-target="#dialog_applyTemplate"><span class="glyphicon glyphicon-random" aria-hidden="true"></span><span class="dropmenu_desc">{$LANG.admin_manage_records_applytemplate}</span></a></li>
					<li><a href="#" data-toggle="modal" data-target="#dialog_importZone"><span class="glyphicon glyphicon-import" aria-hidden="true"></span><span class="dropmenu_desc">{$LANG.admin_manage_records_importzone}</span></a></li>
					<li><a href="#" data-toggle="modal" data-target="#dialog_exportZone" onclick="ExportZone('{$domain->domain}')"><span class="glyphicon glyphicon-export" aria-hidden="true"></span><span class="dropmenu_desc">{$LANG.admin_manage_records_exportzone}</span></a></li>
					<li class="divider"></li>
					<li><a href="#" data-toggle="modal" data-target="#dialog_deleteZone"><span class="glyphicon glyphicon-remove text-danger" aria-hidden="true"></span><span class="dropmenu_desc text-danger">{$LANG.admin_manage_records_deletezone}</span></a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<h2>{$LANG.admin_menu_records}</h2>

<div class="table-container clearfix">
    <table class="dataTable display" id="sdns_records" width="100%" border="0" cellspacing="1" cellpadding="3">
        <thead>
            <tr>
                <th></th>
                <th>{$LANG.global_dns_id}</th>
                <th>{$LANG.global_dns_name}</th>
                <th>{$LANG.global_dns_type}</th>
                <th>{$LANG.global_dns_content}</th>
                <th>{$LANG.global_dns_prio}</th>
                <th>{$LANG.global_dns_ttl}</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="8" class="dataTables_empty">{$LANG.global_table_loading_data}</td>
            </tr>
        </tbody>
    </table>
	<div class="pull-right deleteselected"><a class="btn btn-sm btn-default{if Controller::config(maintenance)} disabled{/if}" href="#" onclick="deleteSelected();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span><span class="dropmenu_desc">{$LANG.admin_manage_records_deleteselected}</span></a></div>
</div>

<!-- Add Modal -->
<div class="bootstrap">
    <div class="modal fade" id="dialog_addRecord" tabindex="-1" role="dialog" aria-labelledby="dialog_addRecord" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$LANG.admin_manage_records_addrecord}</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="sdns_z-name_0" class="col-md-3">
                            <label for="sdns_name_0">{$LANG.global_dns_name}:</label>
                            <input type="text" class="form-padding form-control" name="sdns_name_0" id="sdns_name_0" placeholder="{$domain->domain}">
                        </div>
                        <div class="col-md-2">
                            <label for="sdns_type_0">{$LANG.global_dns_type}:</label>
                            <select class="form-padding form-control" name="sdns_type_0" id="sdns_type_0">
                                {foreach from=$records item=type}
									<option value="{$type}">{$type}</option>
                                {/foreach}
							</select>
                        </div>
                        <div id="sdns_z-content_0" class="col-md-4">
                            <label for="sdns_content_0">{$LANG.global_dns_content}:</label>
                            <input type="text" class="form-padding form-control" name="sdns_content_0" id="sdns_content_0">
                        </div>
                        <div id="sdns_z-prio_0" class="col-md-1">
                            <label for="sdns_prio_0">{$LANG.global_dns_prio}:</label>
                            <input type="text" class="form-padding form-control" name="sdns_prio_0" id="sdns_prio_0">
                        </div>
                        <div class="col-md-2">
                            <label for="sdns_ttl_0">{$LANG.global_dns_ttl}:</label>
							{if Controller::config(preset_ttl)}
								<select class="form-padding form-control" name="sdns_ttl_0" id="sdns_ttl_0">
									<option value="60">1 {$LANG.global_dns_minute}</option>
									<option value="300">5 {$LANG.global_dns_minutes}</option>
									<option SELECTED value="3600">1 {$LANG.global_dns_hour}</option>
									<option value="86400">1 {$LANG.global_dns_day}</option>
								</select>
                            {else}
								<input type="text" class="form-padding form-control" name="sdns_ttl_0" id="sdns_ttl_0" value="3600">
                            {/if}
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" onclick="record_add()">{$LANG.global_btn_add}</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_cancel}</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="bootstrap">
    <div class="modal fade" id="dialog_deleteRecord" tabindex="-1" role="dialog" aria-labelledby="dialog_deleteRecord" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$LANG.global_head_delete_record}</h4>
                </div>
                <div class="modal-body">
                    <p>{$LANG.global_text_delete_record}</p>
                    <br />

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="record_delete()">{$LANG.global_btn_delete}</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_cancel}</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Apply Template -->
<div class="bootstrap">
    <div class="modal fade" id="dialog_applyTemplate" tabindex="-1" role="dialog" aria-labelledby="dialog_applyTemplate" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$LANG.admin_manage_records_applytemplate}</h4>
                </div>
                <form role="form" id="applytemplate">
                    <input type="hidden" name="sdns_form" value="applytemplate">
                    <input type="hidden" name="sdns_domain" value="{$domain->domain}">
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <label for="sdns_apply_template">{$LANG.admin_manage_records_selecttemplate}:</label>
                                <select class="form-padding form-control" name="sdns_apply_template" id="sdns_apply_template">
									{assign var=products value=Controller::product_list()}
									<option value="0">{$LANG.global_general_defaulttemplate}</option>
                                    {foreach from=$products item=product}
										<option value="{$product->id}">{$product->name}</option>
                                    {/foreach}
                                </select>

                            </div>

                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal" onclick="applyTemplate();">{$LANG.global_btn_apply}</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_cancel}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Import Zone -->
<div class="bootstrap">
    <div class="modal fade" id="dialog_importZone" tabindex="-1" role="dialog" aria-labelledby="dialog_importZone" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$LANG.admin_manage_records_importzone}</h4>
                </div>
                <form role="form" id="importzone">
                    <input type="hidden" name="sdns_form" value="importzone">
                    <input type="hidden" name="sdns_domain" value="{$domain->domain}">
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <p>{$LANG.admin_manage_text_importzone}</p>
                                <textarea id="textarea_import" name="sdns_importzone" class="form-padding form-control"></textarea>
                                <div class="checkbox chx_label">
                                    <input id="overwrite" type="checkbox" name="sdns_overwrite"></input>
                                    <label for="overwrite">{$LANG.admin_manage_text_importzoneoverwrite}</label>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal" onclick="importZone();">{$LANG.global_btn_import}</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_cancel}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Export Zone -->
<div class="bootstrap">
    <div class="modal fade" id="dialog_exportZone" tabindex="-1" role="dialog" aria-labelledby="dialog_exportZone" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$LANG.admin_manage_records_exportzone}</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <textarea id="textarea_export" name="sdns_exportzone" class="form-padding form-control">{$LANG.global_table_loading_data}</textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_close}</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Zone -->
<div class="bootstrap">
	<div class="modal fade" id="dialog_deleteZone" tabindex="-1" role="dialog" aria-labelledby="dialog_deleteZone" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">
						<div id="sdns_zone_name">{$LANG.admin_manage_records_deletezone}: <span>{$domain->domain}</span></div>
					</h4>
				</div>
				<div class="modal-body">
					<p>{$LANG.global_text_delete_zone}</p>
					<br />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="zone_delete({$domain->id})">{$LANG.global_btn_delete}</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.global_btn_cancel}</button>
				</div>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="sdns_zone" value="{$domain->domain}">
<input type="hidden" id="sdns_record">

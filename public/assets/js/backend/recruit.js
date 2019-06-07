define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'recruit/index',
                    add_url: 'recruit/add',
                    edit_url: 'recruit/edit',
                    del_url: 'recruit/del',
                    multi_url: 'recruit/multi',
                    table: 'recruit',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'user_id', title: __('User_id')},
                        {field: 'position', title: __('Position')},
                        {field: 'province', title: __('Province')},
                        {field: 'city', title: __('City')},
                        {field: 'district', title: __('District')},
                        {field: 'addr', title: __('Addr')},
                        {field: 'wage', title: __('Wage')},
                        {field: 'company', title: __('Company')},
                        {field: 'tel', title: __('Tel')},
                        {field: 'create_time', title: __('Create_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'update_time', title: __('Update_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'is_delete', title: __('Is_delete')},
                        {field: 'user.id', title: __('User.id')},
                        {field: 'user.group_id', title: __('User.group_id')},
                        {field: 'user.role', title: __('User.role')},
                        {field: 'user.username', title: __('User.username')},
                        {field: 'user.password', title: __('User.password')},
                        {field: 'user.salt', title: __('User.salt')},
                        {field: 'user.mobile', title: __('User.mobile')},
                        {field: 'user.successions', title: __('User.successions')},
                        {field: 'user.maxsuccessions', title: __('User.maxsuccessions')},
                        {field: 'user.prevtime', title: __('User.prevtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'user.logintime', title: __('User.logintime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'user.loginip', title: __('User.loginip')},
                        {field: 'user.loginfailure', title: __('User.loginfailure')},
                        {field: 'user.joinip', title: __('User.joinip')},
                        {field: 'user.jointime', title: __('User.jointime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'user.createtime', title: __('User.createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'user.updatetime', title: __('User.updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'user.token', title: __('User.token')},
                        {field: 'user.status', title: __('User.status'), formatter: Table.api.formatter.status},
                        {field: 'user.verification', title: __('User.verification')},
                        {field: 'user.company_name', title: __('User.company_name')},
                        {field: 'user.project_name', title: __('User.project_name')},
                        {field: 'user.index', title: __('User.index')},
                        {field: 'user.start_time', title: __('User.start_time'), operate:'RANGE', addclass:'datetimerange'},
                        {field: 'user.end_time', title: __('User.end_time'), operate:'RANGE', addclass:'datetimerange'},
                        {field: 'user.can_contact_start_time', title: __('User.can_contact_start_time')},
                        {field: 'user.can_contact_end_time', title: __('User.can_contact_end_time')},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
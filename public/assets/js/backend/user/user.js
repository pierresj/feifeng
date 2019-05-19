define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/user/index',
                    add_url: 'user/user/add',
                    edit_url: 'user/user/edit',
                    del_url: 'user/user/del',
                    multi_url: 'user/user/multi',
                    table: 'user',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'user.id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'), sortable: true},
                        // {field: 'group.name', title: __('Group')},
                        {field: 'role', title: __('Role'),formatter: function(obj){
                                return obj==1?'需求方':'供应方';

                        },searchList: {"1": __('Role 1'), "2": __('Role 2')}},
                        {field: 'username', title: __('Username'), operate: 'LIKE'},
                        // {field: 'company_name', title: '公司名称'},
                        {field: 'mobile', title: '联系电话'},
                        // {field: 'project_name', title: '项目名称'},
                        // {field: 'index', title: '项目类型', formatter: function(value,row, index){
                        //     return row.experience.experience;
                        // }},
                        // {field: 'start_time', title: '开/竣工日期', formatter: function(value,row, index){
                        //     return value + '至' + row.end_time;
                        // }},
                        // {field: 'can_contact_start_time', title: '接电话时间', formatter: function(value,row, index){
                        //     return value + '至' + row.can_contact_end_time;
                        // }},
                        {field: 'jointime', title: '加入时间', formatter: Table.api.formatter.datetime},
                        {field: 'status', title: __('Status'), formatter: Table.api.formatter.status, searchList: {normal: __('Normal'), hidden: __('Hidden')}},
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
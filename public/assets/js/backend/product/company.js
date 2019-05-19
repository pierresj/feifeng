define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/company/index',
                    add_url: 'product/company/add',
                    edit_url: 'product/company/edit',
                    del_url: 'product/company/del',
                    multi_url: 'product/company/multi',
                    table: 'product_company',
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
                        {field: 'company_name', title: __('Company_name')},
                        {field: 'phone', title: __('Phone')},
                        {field: 'province', title: __('Province')},
                        {field: 'city', title: __('City')},
                        {field: 'address', title: __('Address')},
                        // {field: 'status', title: __('Status'),formatter: function(obj){
                        //         return obj ? '通过' : '未通过';
                        //
                        // }},
                        {field: 'status', title: '审核通过',formatter:Table.api.formatter.toggle},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate},
                        // {
                        //     field: 'operate',
                        //     title: __('Operate'),
                        //     table: table,
                        //     events: Table.api.events.operate,
                        //     buttons: [{
                        //         name: 'enable',
                        //         title: '通过',
                        //         classname: 'btn btn-xs btn-default btn-ajax confirm',
                        //         refresh: true,
                        //         icon: 'fa fa-check',
                        //         url: 'product/company/check'
                        //     },
                        //         {
                        //             name: 'disable',
                        //             title: '不通过',
                        //             classname: 'btn btn-xs btn-danger btn-ajax confirm',
                        //             refresh: true,
                        //             icon: 'fa fa-close',
                        //             url: 'product/company/uncheck'
                        //         }],
                        //     formatter: Table.api.formatter.operate
                        // }
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
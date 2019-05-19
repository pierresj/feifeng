define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'designer/index',
                    add_url: 'designer/add',
                    edit_url: 'designer/edit',
                    del_url: 'designer/del',
                    multi_url: 'designer/multi',
                    table: 'designer',
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
                        {field: 'designer_name', title: __('Designer_name')},
                        {field: 'phone', title: __('Phone')},
                        {field: 'province', title: __('Province')},
                        {field: 'city', title: __('City')},
                        {field: 'experience_id', title: __('Experience_id'), cellStyle: function () {return {css: {"max-width": "200px","white-space":"normal"}}}},
                        {field: 'has_card', title: __('Has_card'), formatter: Table.api.formatter.image},
                        {field: 'id_card_image', title: __('Id_card_image'), formatter: Table.api.formatter.image},
                        // {field: 'status', title: __('Status'),formatter: function(obj){
                        //         return obj ? '通过' : '未通过';
                        //
                        // }},
                        {field: 'status', title: '审核通过',formatter:Table.api.formatter.toggle},
                        {field: 'see_pay', title: '付费查看电话', formatter:Table.api.formatter.toggle},
                        {field: 'create_time', title: __('Create_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'update_time', title: __('Update_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
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
                        //         url: 'designer/check'
                        //     },
                        //         {
                        //             name: 'disable',
                        //             title: '不通过',
                        //             classname: 'btn btn-xs btn-danger btn-ajax confirm',
                        //             refresh: true,
                        //             icon: 'fa fa-close',
                        //             url: 'designer/uncheck'
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
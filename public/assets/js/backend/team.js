define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'team/index',
                    add_url: 'team/add',
                    edit_url: 'team/edit',
                    del_url: 'team/del',
                    multi_url: 'team/multi',
                    table: 'team',
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
                        {field: 'user', title: "关联会员"},
                        {field: 'leader_name', title: __('Leader_name')},
                        {field: 'phone', title: __('Phone')},
                        {field: 'member_num', title: __('Member_num')},
                        {field: 'experience_id', title: __('Experience_id'), cellStyle: function () {return {css: {"min-width": "300px","white-space":"normal"}}}},
                        {field: 'dian_gong_num_with_card', title: '电工带证人数'},
                        {field: 'han_gong_num_with_card', title: '焊工带证人数'},
                        {field: 'is_insurance', title: __('Is_insurance'), searchList: {"0":__('Is_insurance 0'),"1":__('Is_insurance 1')}, formatter: Table.api.formatter.normal},
                        // {field: 'status', title: '审核', formatter: function(obj){
                        //     return obj ? '通过' : '未通过';
                        // }},
                        {field: 'status', title: '审核通过',formatter:Table.api.formatter.toggle},
                        {field: 'see_pay', title: '付费查看电话', formatter:Table.api.formatter.toggle},
                        {field: 'avatar', title: __('Avatar'), formatter: Table.api.formatter.image},
                        {field: 'id_card_image', title: __('Id_card_image'), formatter: Table.api.formatter.image},
                        {field: 'province', title: __('Province')},
                        {field: 'city', title: __('City')},
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
                        //         url: 'team/check'
                        //     },
                        //     {
                        //         name: 'disable',
                        //         title: '不通过',
                        //         classname: 'btn btn-xs btn-danger btn-ajax confirm',
                        //         refresh: true,
                        //         icon: 'fa fa-close',
                        //         url: 'team/uncheck'
                        //     }],
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